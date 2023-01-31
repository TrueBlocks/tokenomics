package stats

import (
	"accounting/pkg/traverser"
	"os"
)

func GetAccumulators(opts traverser.Options) []traverser.Traverser[float64] {
	ret := make([]traverser.Traverser[float64], 0)
	for _, a := range os.Args {
		if a == "stats.counter" || a == "counters" || a == "stats" {
			ret = append(ret, &Counter{Opts: opts})
		}
		if a == "total" || a == "stats" {
			ret = append(ret, &Total{Opts: opts})
		}
		if a == "average" || a == "stats" {
			ret = append(ret, &Average{Opts: opts})
		}
		if a == "min" || a == "stats" {
			ret = append(ret, &Min{Opts: opts, Value: 4294967295.})
		}
		if a == "max" || a == "stats" {
			ret = append(ret, &Max{Opts: opts})
		}
	}

	return ret
}
