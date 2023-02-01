package accounting

import (
	"accounting/pkg/mytypes"
	"accounting/pkg/traverser"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type Identity struct {
	Opts     traverser.Options
	NotFirst bool
	Count    uint64
}

func (c *Identity) Traverse(val *mytypes.RawReconciliation) {
	c.Count++
	if c.NotFirst {
		fmt.Println(",")
	} else {
		fmt.Println("[")
	}
	c.NotFirst = true
	fmt.Println(val)
}

func (c *Identity) GetKey(r *mytypes.RawReconciliation) string {
	return ""
}

func (c *Identity) Result() string {
	return "]"
}

func (a *Identity) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off + ": " + fmt.Sprintf("%d", a.Count)
}
