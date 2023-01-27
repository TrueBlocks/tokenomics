package types

type RawType interface {
	float64 | int64 | *RawReconciliation
}
