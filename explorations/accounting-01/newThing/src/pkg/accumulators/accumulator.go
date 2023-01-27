package accums

import (
	"accounting/pkg/types"
)

type Accumulator[T types.RawType] interface {
	Accumulate(val T)
	Result() string
	Name() string
}
