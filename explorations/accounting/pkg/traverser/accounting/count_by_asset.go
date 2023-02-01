package accounting

import (
	"accounting/pkg/mytypes"
	"accounting/pkg/traverser"
	"fmt"
	"reflect"
	"sort"
	"strings"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type CountByAsset struct {
	Opts   traverser.Options
	Values map[string]uint64
}

func (c *CountByAsset) Traverse(r *mytypes.RawReconciliation) {
	if len(c.Values) == 0 {
		c.Values = make(map[string]uint64)
	}
	c.Values[c.GetKey(r)]++
}

func (c *CountByAsset) GetKey(r *mytypes.RawReconciliation) string {
	return string(r.AssetAddress) + "_" + r.AssetSymbol
}

func (c *CountByAsset) Result() string {
	return c.Name() + "\n" + c.reportValues("Assets", c.Values)
}

func (c *CountByAsset) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *CountByAsset) reportValues(msg string, m map[string]uint64) string {
	type stats struct {
		Address string
		Symbol  string
		Count   uint64
	}
	nTransfers := 0

	arr := make([]stats, 0, len(m))
	for k, v := range m {
		parts := strings.Split(k, "_")
		arr = append(arr, stats{Count: v, Address: parts[0], Symbol: parts[1]})
		nTransfers += int(v)
	}
	sort.Slice(arr, func(i, j int) bool {
		if arr[i].Count == arr[j].Count {
			if arr[i].Address == arr[j].Address {
				return arr[i].Symbol < arr[j].Symbol
			}
			return arr[i].Address < arr[j].Address
		}
		return arr[i].Count > arr[j].Count
	})

	ret := fmt.Sprintf("Number of %s: %d\n", msg, len(c.Values))
	ret += fmt.Sprintf("Number of Transfers: %d\n\n", nTransfers)

	ret += "Count,Asset,Symbol\n"
	for _, val := range arr {
		ret += fmt.Sprintf("%d,%s,%s\n", val.Count, val.Address, val.Symbol)
	}

	return ret
}
