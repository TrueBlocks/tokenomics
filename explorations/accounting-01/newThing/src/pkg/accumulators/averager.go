package accums

import (
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type Averager struct {
	Counter
	Totaler
}

func (a *Averager) Accumulate(val float64) {
	a.Count += 1
	a.Total += val
}

func (a *Averager) Result() string {
	return a.Name() + ": " + fmt.Sprintf("%.5f", a.Total/a.Count)
}

func (a *Averager) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off
}
