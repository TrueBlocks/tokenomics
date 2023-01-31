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
type GroupByPriced struct {
	Opts   traverser.Options
	Values map[string]uint64
}

func (c *GroupByPriced) Accumulate(r *mytypes.RawReconciliation) {
	if len(c.Values) == 0 {
		c.Values = make(map[string]uint64)
	}
	c.Values[c.GetKey(r)]++
}

func (c *GroupByPriced) GetKey(r *mytypes.RawReconciliation) string {
	status := "unpriced"
	if r.SpotPrice > 0 {
		status = "priced"
	}
	return status + "_" + string(r.AssetAddress) + "_" + r.AssetSymbol
}

func (c *GroupByPriced) Result() string {
	return c.Name() + "\n" + c.reportValues("Assets", c.Values)
}

func (c *GroupByPriced) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *GroupByPriced) reportValues(msg string, m map[string]uint64) string {
	type stats struct {
		Address string
		Symbol  string
		Count   uint64
		Status  string
	}
	nTransfers := 0
	nPriced := 0

	arr := make([]stats, 0, len(m))
	for k, v := range m {
		parts := strings.Split(k, "_")
		arr = append(arr, stats{Count: v, Status: parts[0], Address: parts[1], Symbol: parts[2]})
		nTransfers += int(v)
		if parts[0] == "priced" {
			nPriced += int(v)
		}
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
	ret += fmt.Sprintf("Number of Transfers: %d\n", nTransfers)

	ret += ExportHeader("Priced Assets", nPriced)
	ret += "Count,Asset,Symbol\n"
	for _, val := range arr {
		if val.Status == "priced" {
			ret += fmt.Sprintf("%d,%s,%s\n", val.Count, val.Address, val.Symbol)
		}
	}

	ret += ExportHeader("Unpriced Assets", nTransfers-nPriced)
	ret += "Count,Address,Symbol\n"
	for _, val := range arr {
		if val.Status == "unpriced" {
			ret += fmt.Sprintf("%d,%s,%s\n", val.Count, val.Address, val.Symbol)
		}
	}

	return ret
}
