package logs

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
type CountByTopic struct {
	Opts   traverser.Options
	Values map[string]uint64
}

func (c *CountByTopic) Traverse(r *mytypes.RawLog) {
	if len(c.Values) == 0 {
		c.Values = make(map[string]uint64)
	}
	c.Values[c.GetKey(r)]++
}

func (c *CountByTopic) GetKey(r *mytypes.RawLog) string {
	return r.Topic0 + "_" + strings.Split(strings.Replace(strings.Replace(r.CompressedLog, "{name:", "", -1), "}", "", -1), "|")[0]
}

func (c *CountByTopic) Result() string {
	return c.Name() + "\n" + c.reportValues("Logs", c.Values)
}

func (c *CountByTopic) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *CountByTopic) reportValues(msg string, m map[string]uint64) string {
	type stats struct {
		Topic string
		Name  string
		Count uint64
	}
	nTopics := 0

	arr := make([]stats, 0, len(m))
	for k, v := range m {
		nTopics++
		parts := strings.Split(k, "_")
		arr = append(arr, stats{Count: v, Topic: parts[0], Name: parts[1]})
	}
	sort.Slice(arr, func(i, j int) bool {
		if arr[i].Count == arr[j].Count {
			if arr[i].Topic == arr[j].Topic {
				return arr[i].Name < arr[j].Name
			}
			return arr[i].Topic < arr[j].Topic
		}
		return arr[i].Count > arr[j].Count
	})

	ret := fmt.Sprintf("Number of %s: %d\n", msg, len(c.Values))
	ret += fmt.Sprintf("Number of Topics: %d\n", nTopics)

	ret += "Count,Topic,Name\n"
	for _, val := range arr {
		ret += fmt.Sprintf("%d,%s,%s\n", val.Count, val.Topic, val.Name)
	}
	return ret
}
