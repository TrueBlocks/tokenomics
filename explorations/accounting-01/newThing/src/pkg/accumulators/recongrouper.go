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
type ReconGrouper struct {
	Priced   map[string]uint64
	Unpriced map[string]uint64
}

func (c *ReconGrouper) Accumulate(r *types.RawReconciliation) {
	if r.SpotPrice == 0 {
		if len(c.Unpriced) == 0 {
			c.Unpriced = make(map[string]uint64)
		}
		c.Unpriced[r.AssetSymbol]++
	} else {
		if len(c.Priced) == 0 {
			c.Priced = make(map[string]uint64)
		}
		c.Priced[r.AssetSymbol]++
	}
}

func (c *ReconGrouper) Result() string {
	return c.Name() + ": " + reportOn("Priced", c.Priced) + reportOn("Unpriced", c.Unpriced)
}

func (a *ReconGrouper) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off
}

func reportOn(name string, m map[string]uint64) string {
	arr := make([]string, 0, len(m))
	for k, v := range m {
		arr = append(arr, fmt.Sprintf("%010d|%s|%d", v, k, v))
	}
	sort.Slice(arr, func(i, j int) bool {
		return arr[i] > arr[j]
	})

	l := 0
	ret := "\n- " + fmt.Sprintf(name+": %d\n", len(m))
	ret += "\t"
	for _, str := range arr {
		parts := strings.Split(str, "|")
		item := fmt.Sprintf("%s (%s), ", parts[1], parts[2])
		l += len(item)
		if l > 90 {
			ret += "\n\t"
			l = 0
		}
		ret += item
	}
	return ret
}
