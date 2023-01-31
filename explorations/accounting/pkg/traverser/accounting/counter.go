package accounting

import (
	"accounting/pkg/mytypes"
	"accounting/pkg/traverser"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type Counter struct {
	Opts  traverser.Options
	Value uint64
}

func (c *Counter) Accumulate(r *mytypes.RawReconciliation) {
	c.Value += 1
}

func (c *Counter) GetKey(r *mytypes.RawReconciliation) string {
	return ""
}

func (c *Counter) Result() string {
	return c.Name() + "\n\t" + c.reportValue("Counter: ", c.Value)
}

func (c *Counter) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *Counter) reportValue(msg string, v uint64) string {
	return fmt.Sprintf("%s%d", msg, v)
}
