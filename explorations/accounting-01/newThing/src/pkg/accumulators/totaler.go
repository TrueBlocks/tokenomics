package accums

import (
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type Totaler struct {
	Total float64
}

func (c *Totaler) Accumulate(val float64) {
	c.Total += val
}

func (c *Totaler) Result() string {
	return c.Name() + ": " + fmt.Sprintf("%.5f", c.Total)
}

func (a *Totaler) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off
}
