package stats

import (
	"accounting/pkg/traverser"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type Counter struct {
	Opts  traverser.Options
	Value float64
}

func (c *Counter) Accumulate(val float64) {
	c.Value += 1
}

func (c *Counter) GetKey(unused float64) string {
	return ""
}

func (c *Counter) Result() string {
	return c.Name() + "\n\t" + c.reportValue("Counter: ", c.Value)
}

func (c *Counter) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *Counter) reportValue(msg string, v float64) string {
	return fmt.Sprintf("%s%f", msg, v)
}
