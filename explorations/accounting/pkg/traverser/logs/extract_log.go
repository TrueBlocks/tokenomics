package logs

import (
	"accounting/pkg/mytypes"
	"accounting/pkg/traverser"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type ExtractLog struct {
	Opts  traverser.Options
	Count uint64
	// w     *tabwriter.Writer
}

func (c *ExtractLog) Traverse(l *mytypes.RawLog) {
	if c.Count == 0 {
		// c.w = tabwriter.NewWriter(os.Stdout, 0, 0, 1, ',', 0)
		c.ReportHeader(c.Opts.Verbose, l)
	}
	c.ReportRecord(l)
	c.Count++
}

func (c *ExtractLog) GetKey(r *mytypes.RawLog) string {
	return ""
}

func (c *ExtractLog) Result() string {
	return ""
}

func (a *ExtractLog) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off + ": " + fmt.Sprintf("%d", a.Count)
}

func (c *ExtractLog) ReportHeader(verbose int, r *mytypes.RawLog) {
	if verbose > 0 {
		fmt.Println("Block\tTx\tLog\tAddress\tTopics\tData\t")
	}
}

func (c *ExtractLog) ReportRecord(r *mytypes.RawLog) {
	// if c.Count%20 == 0 {
	// 	c.w.Flush()
	// }
	fmt.Printf("%s\t%s\t%s\t%s\t%s\n", r.BlockNumber, r.TransactionIndex, r.LogIndex, r.Address, r.CompressedLog)
}
