package accums

import (
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type Counter struct {
	Count float64
}

func (c *Counter) Accumulate(unused float64) {
	c.Count += 1
}

func (c *Counter) Result() string {
	return c.Name() + ": " + fmt.Sprintf("%.5f", c.Count)
}

func (a *Counter) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off
}
