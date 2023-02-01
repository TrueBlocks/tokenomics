package stats

import (
	"accounting/pkg/traverser"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type Total struct {
	Opts  traverser.Options
	Value float64
}

func (c *Total) Traverse(val float64) {
	c.Value += val
}

func (c *Total) GetKey(unused float64) string {
	return ""
}

func (c *Total) Result() string {
	return c.Name() + "\n\t" + c.reportValue("Total: ", c.Value)
}

func (c *Total) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *Total) reportValue(msg string, v float64) string {
	return fmt.Sprintf("%s%f", msg, v)
}
