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
		if a == "contract_only" {
			ret = append(ret, &CountByContract{Opts: opts, Mode: "contract_only"})
		}
		if a == "topic_only" {
			ret = append(ret, &CountByContract{Opts: opts, Mode: "topic_only"})
		}
		if a == "contract_last" {
			ret = append(ret, &CountByContract{Opts: opts, Mode: "contract_last"})
		}
		if a == "contract_first" {
			ret = append(ret, &CountByContract{Opts: opts, Mode: "contract_first"})
		}

		// if strings.Contains(a, "by_address") || a == "groups" {
		// 	ret = append(ret, &GroupByAddress{Opts: opts, Source: "senders"})
		// 	ret = append(ret, &GroupByAddress{Opts: opts, Source: "recipients"})
		// 	ret = append(ret, &GroupByAddress{Opts: opts, Source: "pairings"})
		// }
		// if a == "senders" {
		// 	ret = append(ret, &GroupByAddress{Opts: opts, Source: "senders"})
		// }
		// if a == "recipients" {
		// 	ret = append(ret, &GroupByAddress{Opts: opts, Source: "recipients"})
		// }
		// if a == "pairings" {
		// 	ret = append(ret, &GroupByAddress{Opts: opts, Source: "pairings"})
		// }
		if a == "extract" {
			ret = append(ret, &ExtractLog{Opts: opts})
		}
	}
	return ret
}

func ExportHeader(msg string, count int) string {
	return fmt.Sprintf("\n%s: %d\n", msg, count)
}
