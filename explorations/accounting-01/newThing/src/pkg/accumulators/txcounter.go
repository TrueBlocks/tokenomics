package accums

import (
	"accounting/pkg/types"
	"fmt"
	"reflect"
	"sort"
	"strings"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type TxCounter struct {
	Assets map[string]uint64
}

func (c *TxCounter) Accumulate(r *types.RawReconciliation) {
	if len(c.Assets) == 0 {
		c.Assets = make(map[string]uint64)
	}
	c.Assets[r.AssetSymbol+"|"+string(r.AssetAddress)]++
}

func (c *TxCounter) Result() string {
	return c.Name() + ":" + reportAsset("Assets", c.Assets)
}

func (a *TxCounter) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off
}

func reportAsset(name string, m map[string]uint64) string {
	arr := make([]string, 0, len(m))
	for k, v := range m {
		arr = append(arr, fmt.Sprintf("%010d|%s|%d", v, k, v))
	}
	sort.Slice(arr, func(i, j int) bool {
		return arr[i] > arr[j]
	})

	cnt := 0
	ret := "\n- " + fmt.Sprintf(name+": %d\n", len(m))
	ret += "\t"
	for _, str := range arr {
		parts := strings.Split(str, "|")
		p := parts[1]
		if len(p) > 10 {
			p = p[:10]
		}
		item := fmt.Sprintf("%-20.20s%s %s (%s), ", colors.BrightBlue+p, colors.Off, parts[2], colors.Green+parts[3]+colors.Off)
		cnt++
		if cnt%2 == 0 {
			ret += "\n\t"
		}
		ret += item
	}
	return ret
}
