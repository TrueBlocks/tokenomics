package accounting

import (
	"accounting/pkg/mytypes"
	"accounting/pkg/traverser"
	"fmt"
	"reflect"
	"sort"
	"strings"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type CountByFunction struct {
	Opts   traverser.Options
	Values map[string]uint64
}

func (c *CountByFunction) Traverse(r *mytypes.RawReconciliation) {
	if len(c.Values) == 0 {
		c.Values = make(map[string]uint64)
	}
	c.Values[c.GetKey(r)]++
}

func (c *CountByFunction) GetKey(r *mytypes.RawReconciliation) string {
	return r.Encoding + "_" + strings.Split(strings.Replace(strings.Replace(r.Signature, "{name:", "", -1), "}", "", -1), "|")[0]
}

func (c *CountByFunction) Result() string {
	return c.Name() + "\n" + c.reportValues("Functions", c.Values)
}

func (c *CountByFunction) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *CountByFunction) reportValues(msg string, m map[string]uint64) string {
	type stats struct {
		Encoding string
		Name     string
		Count    uint64
		Status   string
	}
	nTransfers := 0
	nEthTransfers := 0
	nNamed := 0
	nMessages := 0

	arr := make([]stats, 0, len(m))
	for k, v := range m {
		parts := strings.Split(k, "_")
		status := "unnamed"
		if len(parts[1]) > 0 && parts[0] != parts[1] {
			if strings.HasPrefix(parts[1], "message:") {
				status = "message"
			} else {
				status = "named"
			}
		}
		arr = append(arr, stats{Count: v, Encoding: parts[0], Name: parts[1], Status: status})

		nTransfers += int(v)
		if parts[0] == "0x" {
			nEthTransfers += int(v)
		} else if status == "named" {
			nNamed += int(v)
		} else if status == "message" {
			nMessages += int(v)
		}
	}
	sort.Slice(arr, func(i, j int) bool {
		if arr[i].Count == arr[j].Count {
			if arr[i].Encoding == arr[j].Encoding {
				return arr[i].Name < arr[j].Name
			}
			return arr[i].Encoding < arr[j].Encoding
		}
		return arr[i].Count > arr[j].Count
	})

	ret := fmt.Sprintf("Number of %s: %d\n", msg, len(c.Values))
	ret += fmt.Sprintf("Number of Transfers: %d\n", nTransfers)

	ret += ExportHeader("Calls to Named Functions", nNamed)
	ret += "Count,Encoding,Name\n"
	for _, val := range arr {
		if val.Status == "named" {
			ret += fmt.Sprintf("%d,%s,%s\n", val.Count, val.Encoding, val.Name)
		}
	}

	ret += ExportHeader("Calls to Unnamed Functions", nTransfers-nNamed-nMessages-nEthTransfers)
	ret += "Count,Encoding,Name\n"
	for _, val := range arr {
		if val.Status != "named" && val.Status != "message" && val.Encoding != "0x" {
			ret += fmt.Sprintf("%d,%s,%s\n", val.Count, val.Encoding, val.Name)
		}
	}

	ret += ExportHeader("Eth Transfers", nEthTransfers)
	ret += "Count,Encoding,Name\n"
	for _, val := range arr {
		if val.Encoding == "0x" {
			ret += fmt.Sprintf("%d,%s,%s\n", val.Count, val.Encoding, val.Name)
		}
	}

	ret += ExportHeader("Messages", nMessages)
	ret += "Count,Message\n"
	for _, val := range arr {
		if val.Status == "message" {
			ret += fmt.Sprintf("%d,%s\n", val.Count, val.Name)
		}
	}

	return ret
}
