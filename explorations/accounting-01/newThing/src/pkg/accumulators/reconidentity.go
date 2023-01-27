package accums

import (
	"accounting/pkg/types"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type ReconIdentity struct {
	NotFirst bool
	Count    uint64
}

func (c *ReconIdentity) Accumulate(val *types.RawReconciliation) {
	c.Count++
	if c.NotFirst {
		fmt.Println(",")
	} else {
		fmt.Println("[")
	}
	c.NotFirst = true
	fmt.Println(val)
}

func (c *ReconIdentity) Result() string {
	return "]"
}

func (a *ReconIdentity) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off + ": " + fmt.Sprintf("%d", a.Count)
}
