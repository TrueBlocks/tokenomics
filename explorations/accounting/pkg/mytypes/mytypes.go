package mytypes

type RawType interface {
	float64 | int64 | *RawReconciliation
}
