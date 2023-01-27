package accums

import (
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type Max struct {
	Max float64
}

func (a *Max) Accumulate(val float64) {
	if val > a.Max {
		a.Max = val
	}
}

func (a *Max) Result() string {
	return a.Name() + ": " + fmt.Sprintf("%.5f", a.Max)
}

func (a *Max) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off
}
