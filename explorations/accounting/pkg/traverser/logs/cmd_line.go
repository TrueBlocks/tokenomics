package logs

import (
	"accounting/pkg/mytypes"
	"accounting/pkg/traverser"
	"fmt"
	"os"
)

func GetTraversers(opts traverser.Options) []traverser.Traverser[*mytypes.RawLog] {
	ret := make([]traverser.Traverser[*mytypes.RawLog], 0)
	for _, a := range os.Args {
		if a == "logs.counter" || a == "counters" {
			ret = append(ret, &Counter{Opts: opts})
		}
		if a == "logs.by_topic" || a == "by_topic" {
			ret = append(ret, &CountByTopic{Opts: opts})
		}
	}
	return ret
}

func ExportHeader(msg string, count int) string {
	return fmt.Sprintf("\n%s: %d\n", msg, count)
}
