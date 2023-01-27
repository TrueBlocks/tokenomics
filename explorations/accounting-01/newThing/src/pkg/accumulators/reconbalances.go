package accums

import (
	"accounting/pkg/types"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type ReconBalances struct {
	NotFirst bool
}

func (c *ReconBalances) Accumulate(r *types.RawReconciliation) {
	c.NotFirst = true
	fmt.Printf("%s\t%s\t%s\t%s\t%s\t%s\t%s\n",
		r.Date.String(),
		r.AccountedFor,
		r.AssetAddress,
		r.AssetSymbol,
		r.BegBal.String(),
		r.AmountNet,
		r.EndBal,
	)
}

func (c *ReconBalances) Result() string {
	return "" // "]"
}

func (a *ReconBalances) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off
}
