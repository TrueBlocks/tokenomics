package stats

import (
	"accounting/pkg/traverser"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type Average struct {
	Opts  traverser.Options
	Value float64
	Total float64
}

func (c *Average) Traverse(val float64) {
	c.Value += 1
	c.Total += val
}

func (c *Average) GetKey(unused float64) string {
	return ""
}

func (c *Average) Result() string {
	if c.Value == 0 {
		return c.Name() + "\n\t" + c.reportValue("Average: ", 0)
	}
	return c.Name() + "\n\t" + c.reportValue("Average: ", c.Total/c.Value)
}

func (c *Average) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *Average) reportValue(msg string, v float64) string {
	return fmt.Sprintf("%s%f", msg, v)
}
