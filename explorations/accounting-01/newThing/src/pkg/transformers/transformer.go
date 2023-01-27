package transformers

import (
	accums "accounting/pkg/accumulators"
	"accounting/pkg/types"
)

type Transformer[T types.RawType] interface {
	Transform(val T) T
	accums.Accumulator[T]
}
