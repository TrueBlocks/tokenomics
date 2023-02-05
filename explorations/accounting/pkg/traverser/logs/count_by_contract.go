package logs

import (
	"accounting/pkg/mytypes"
	"accounting/pkg/traverser"
	"fmt"
	"reflect"
	"sort"
	"strings"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
	"github.com/ethereum/go-ethereum/common"
)

// --------------------------------
type CountByContract struct {
	Opts   traverser.Options
	Mode   string
	Values map[string]uint64
}

func (c *CountByContract) Traverse(r *mytypes.RawLog) {
	if len(c.Values) == 0 {
		c.Values = make(map[string]uint64)
	}
	c.Values[c.GetKey(r)]++
}

func (c *CountByContract) GetKey(r *mytypes.RawLog) string {
	name := c.Opts.Names[common.HexToAddress(r.Address)].Name
	if name == "" {
		name = "Unknown"
	}
	funcName := strings.Split(strings.Replace(strings.Replace(r.CompressedLog, "{name:", "", -1), "}", "", -1), "|")[0]
	if funcName == "" {
		funcName = "Unknown"
	}

	switch c.Mode {
	case "topic_only":
		return r.Topic0 + "_" + funcName
	case "contract_only":
		return r.Address + "_" + name
	case "contract_last":
		return r.Topic0 + "_" + funcName + "_" + r.Address + "_" + name
	case "contract_first":
		fallthrough
	default:
		return r.Address + "_" + name + "_" + r.Topic0 + "_" + funcName
	}
}

func (c *CountByContract) Result() string {
	return c.Name() + "\n" + c.reportValues("TopicsPerContract", c.Values)
}

func (c *CountByContract) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *CountByContract) reportValues(msg string, m map[string]uint64) string {
	type stats struct {
		Contract string
		Name     string
		Topic    string
		Function string
		Count    uint64
	}
	nRecords := uint64(0)

	arr := make([]stats, 0, len(m))
	for k, v := range m {
		nRecords += v
		parts := strings.Split(k, "_")
		switch c.Mode {
		case "topic_only":
			arr = append(arr, stats{Count: v, Topic: parts[0], Function: parts[1]})
		case "contract_only":
			arr = append(arr, stats{Count: v, Contract: parts[0], Name: parts[1]})
		case "contract_last":
			arr = append(arr, stats{Count: v, Topic: parts[0], Function: parts[1], Contract: parts[2], Name: parts[3]})
		case "contract_first":
			fallthrough
		default:
			arr = append(arr, stats{Count: v, Contract: parts[0], Name: parts[1], Topic: parts[2], Function: parts[3]})
		}
	}
	sort.Slice(arr, func(i, j int) bool {
		if arr[i].Count == arr[j].Count {
			if arr[i].Topic == arr[j].Topic {
				return arr[i].Contract < arr[j].Contract
			}
			return arr[i].Topic < arr[j].Topic
		}
		return arr[i].Count > arr[j].Count
	})

	ret := fmt.Sprintf("Number of %s: %d\n", msg, len(c.Values))
	ret += fmt.Sprintf("Number of Topics: %d\n", nRecords)

	for i, val := range arr {
		switch c.Mode {
		case "topic_only":
			if i == 0 {
				ret += "Count,Topic,FuncName\n"
			}
			ret += fmt.Sprintf("%d,%s,%s\n", val.Count, val.Topic, val.Function)
		case "contract_only":
			if i == 0 {
				ret += "Count,Contract,Name\n"
			}
			ret += fmt.Sprintf("%d,%s,%s\n", val.Count, val.Contract, val.Name)
		case "contract_last":
			if i == 0 {
				ret += "Count,Topic,FuncName,Contract,Name\n"
			}
			ret += fmt.Sprintf("%d,%s,%s,%s,%s\n", val.Count, val.Topic, val.Function, val.Contract, val.Name)
		case "contract_first":
			fallthrough
		default:
			if i == 0 {
				ret += "Count,Contract,Name,Topic,FuncName\n"
			}
			ret += fmt.Sprintf("%d,%s,%s,%s,%s\n", val.Count, val.Contract, val.Name, val.Topic, val.Function)
		}
	}

	return ret
}
