package accums

import (
	"accounting/pkg/types"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type ReconCounter struct {
	Count uint64
}

func (c *ReconCounter) Accumulate(val *types.RawReconciliation) {
	c.Count += 1
}

func (c *ReconCounter) Result() string {
	return c.Name() + ": " + fmt.Sprintf("%d", c.Count)
}

func (a *ReconCounter) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off
}
