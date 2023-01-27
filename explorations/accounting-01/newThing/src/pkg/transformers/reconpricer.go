package transformers

import (
	"accounting/pkg/types"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type ReconPricer struct {
}

func (c *ReconPricer) Transform(val *types.RawReconciliation) *types.RawReconciliation {
	return val
}

func (c *ReconPricer) Accumulate(val *types.RawReconciliation) {
}

func (c *ReconPricer) Result() string {
	return fmt.Sprintf("%d", 0)
}

func (a *ReconPricer) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off
}
