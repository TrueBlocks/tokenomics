package accums

import (
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type Min struct {
	Min float64
}

func (a *Min) Accumulate(val float64) {
	if val < a.Min {
		a.Min = val
	}
}

func (a *Min) Result() string {
	return a.Name() + ": " + fmt.Sprintf("%.5f", a.Min)
}

func (a *Min) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off
}
