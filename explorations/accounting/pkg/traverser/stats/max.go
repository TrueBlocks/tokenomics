package stats

import (
	"accounting/pkg/traverser"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type Max struct {
	Opts  traverser.Options
	Value float64
}

func (c *Max) Accumulate(val float64) {
	if val > c.Value {
		c.Value = val
	}
}

func (c *Max) GetKey(unused float64) string {
	return ""
}

func (c *Max) Result() string {
	return c.Name() + "\n\t" + c.reportValue("Max: ", c.Value)
}

func (c *Max) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *Max) reportValue(msg string, v float64) string {
	return fmt.Sprintf("%s%f", msg, v)
}
