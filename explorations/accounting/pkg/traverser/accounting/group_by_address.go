package accounting

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
type GroupByAddress struct {
	Opts   traverser.Options
	Source string
	Values map[string]uint64
}

func (c *GroupByAddress) Accumulate(r *mytypes.RawReconciliation) {
	if len(c.Values) == 0 {
		c.Values = make(map[string]uint64)
	}
	c.Values[c.GetKey(r)]++
}

func (c *GroupByAddress) GetKey(r *mytypes.RawReconciliation) string {
	switch c.Source {
	case "senders":
		return c.Source + "_" + r.Sender.String()
	case "recipients":
		return c.Source + "_" + r.Recipient.String()
	case "pairings":
		fallthrough
	default:
		return c.Source + "_" + r.Sender.String() + "_" + r.Recipient.String()
	}
}

func (c *GroupByAddress) Result() string {
	return c.Name() + "\n" + c.reportValues("Addresses", c.Values)
}

func (c *GroupByAddress) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *GroupByAddress) reportValues(msg string, m map[string]uint64) string {
	type stats struct {
		Address string
		Name    string
		Count   uint64
		Status  string
	}
	nTransfers := 0
	nSenders := 0
	nRecipients := 0
	nPairs := 0

	arr := make([]stats, 0, len(m))
	for k, v := range m {
		parts := strings.Split(k, "_")
		record := stats{Count: v, Status: parts[0], Address: parts[1], Name: c.Opts.Names[common.HexToAddress(parts[1])].Name}
		if len(parts) > 2 {
			record.Address = parts[1] + "," + c.Opts.Names[common.HexToAddress(parts[1])].Name
			record.Name = parts[2] + "," + c.Opts.Names[common.HexToAddress(parts[2])].Name
		}
		arr = append(arr, record)

		nTransfers += int(v)
		switch c.Source {
		case "senders":
			nSenders++
		case "recipients":
			nRecipients++
		case "pairings":
			nPairs++
		}
	}
	sort.Slice(arr, func(i, j int) bool {
		if arr[i].Count == arr[j].Count {
			if arr[i].Address == arr[j].Address {
				return arr[i].Name < arr[j].Name
			}
			return arr[i].Address < arr[j].Address
		}
		return arr[i].Count > arr[j].Count
	})

	proper := strings.ToUpper(c.Source[:1]) + c.Source[1:len(c.Source)]
	ret := fmt.Sprintf("Number of %s: %d\n", proper, nSenders)
	ret += fmt.Sprintf("Number of Transfers: %d\n\n", nTransfers)

	source := proper[:len(proper)-1]
	ret += source + "\n"
	if c.Source == "pairings" {
		ret += "Count,Sender,Sender Name,Recipient,Recipient Name\n"
	} else {
		ret += "Count," + source + "," + source + " Name\n"
	}
	for _, val := range arr {
		if val.Status == c.Source {
			ret += fmt.Sprintf("%d,%s,%s\n", val.Count, val.Address, val.Name)
		}
	}

	return ret
}
