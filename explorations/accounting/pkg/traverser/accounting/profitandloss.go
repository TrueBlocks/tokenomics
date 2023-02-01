package accounting

import (
	"accounting/pkg/mytypes"
	"accounting/pkg/traverser"
	"accounting/pkg/utils"
	"math/big"
	"os"
	"strings"
	"text/tabwriter"

	//    "accounting/pkg/utils"
	"fmt"
	"reflect"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/names"
	"github.com/ethereum/go-ethereum/common"
)

// --------------------------------
type ProfitAndLoss struct {
	Opts     traverser.Options
	LastDate string
	Ledgers  map[string]*mytypes.RawReconciliation
	LastKey  string
	w        *tabwriter.Writer
}

func (c *ProfitAndLoss) Accumulate(r *mytypes.RawReconciliation) {
	if len(c.Ledgers) == 0 {
		c.w = tabwriter.NewWriter(os.Stdout, 0, 0, 1, ',', 0)
		if c.Ledgers == nil { // order matters
			c.ReportHeader(c.Opts.Verbose, r)
		}
		c.Ledgers = make(map[string]*mytypes.RawReconciliation)
		c.LastKey = ""
	}

	if len(c.Opts.Filters) > 0 && !c.Opts.Filters[r.AssetAddress] {
		return
	}

	// fmt.Println(r)
	key := c.GetKey(r)
	l := c.Ledgers[key]
	if l != nil {
		// We have this ledger, so first report on the current reconciliation...
		if c.Opts.Verbose > 0 {
			c.Report("Tx", colors.BrightCyan, r.SpotPrice, r)
		}
		// ...then accumulate it into the ledger
		c.UpdateLedger(key, r)

	} else {
		if c.LastKey != "" {
			c.Report("Summary", colors.BrightYellow, r.SpotPrice, c.Ledgers[c.LastKey])
			if colors.White != "" {
				fmt.Fprintln(c.w)
			}
		}
		if c.Opts.Verbose > 0 {
			c.Report("Tx", colors.BrightCyan, r.SpotPrice, r)
		}
		// Remember the current ledger
		c.Ledgers[key] = r
	}

	c.LastDate = mytypes.GetDateKey(c.Opts.Period, r.Date)
	c.LastKey = key
}

func (c *ProfitAndLoss) GetKey(r *mytypes.RawReconciliation) string {
	if c.Opts.Period == "blockly" {
		return fmt.Sprintf("%s-%08d", c.GetAsset(r), r.BlockNumber)
	}

	return fmt.Sprintf("%s-%s", c.GetAsset(r), mytypes.GetDateKey(c.Opts.Period, r.Date))
}

func (c *ProfitAndLoss) GetAsset(r *mytypes.RawReconciliation) string {
	return fmt.Sprintf("%s-%s-%s", r.AssetAddress.String(), r.AssetSymbol, r.AccountedFor.String())
}

func (c *ProfitAndLoss) Result() string {
	return ""
}

func (a *ProfitAndLoss) Name() string {
	return colors.Green + reflect.TypeOf(a).Elem().String() + colors.Off
}

func ToFmtStrFloat(denom string, decimals uint64, spot float64, x string) string {
	bigTotIn := big.Float{}
	bigTotIn.SetString(x)
	return ToFmtStr(denom, decimals, spot, &bigTotIn)
}

func ToFmtStr(denom string, decimals uint64, spot float64, x *big.Float) string {
	v := *x
	switch denom {
	case "units":
		one := big.Float{}
		one.SetFloat64(1)
		v = *utils.PriceUsd(v.String(), decimals, &one)
		return v.Text('f', int(decimals))
	case "usd":
		sp := big.Float{}
		sp.SetFloat64(spot)
		v = *utils.PriceUsd(v.String(), decimals, &sp)
		return v.Text('f', 6)
	case "wei":
		fallthrough
	default:
		return v.Text('f', 0)
	}
}

func (c *ProfitAndLoss) UpdateLedger(key string, r *mytypes.RawReconciliation) {
	c.Ledgers[key].AmountNet.Add(&c.Ledgers[key].AmountNet, &r.AmountNet)
	c.Ledgers[key].EndBal = r.EndBal
}

func Display(color string, a mytypes.Address, aF *mytypes.Address, verbose int, nMap names.NamesMap) string {
	n := nMap[common.HexToAddress(a.String())].Name
	n = strings.Replace(strings.Replace(n, ",", "", -1), "#", "", -1)
	if len(n) > 0 {
		n = "," + n
	} else {
		n = "," + colors.BrightBlack + names.AddrToPetname(a.String(), "-") + colors.Off
	}

	ad := a.String()
	if aF != nil && a == *aF {
		return colors.Green + ad + colors.Off + n
	}

	if verbose > 0 {
		return color + ad + colors.Off + n
	}

	if len(ad) < 15 {
		return color + ad + strings.Repeat(" ", 17-len(ad)) + colors.Off + n
	}
	return color + ad[0:8] + "..." + ad[len(ad)-6:] + colors.Off + n
}

func (c *ProfitAndLoss) Report(msg, color string, spot float64, r *mytypes.RawReconciliation) {
	if len(c.Opts.Filters) > 0 && !c.Opts.Filters[r.AssetAddress] {
		return
	}

	f := func(x big.Float) uint64 {
		v, _ := x.Uint64()
		return v
	}

	denom := c.Opts.Denom
	if denom == "usd" && r.SpotPrice == 0 {
		denom = "not-priced"
	}
	date := colors.Red + mytypes.GetDateKey(c.Opts.Period, r.Date)
	if msg != "Summary" {
		date = colors.Red + mytypes.GetDateKey("secondly", r.Date)
	}
	symbol := colors.Green + r.AssetSymbol
	asset := color + Display(color, r.AssetAddress, nil, c.Opts.Verbose, c.Opts.Names)
	sender := Display(color, r.Sender, &r.AccountedFor, c.Opts.Verbose, c.Opts.Names)
	recipient := Display(color, r.Recipient, &r.AccountedFor, c.Opts.Verbose, c.Opts.Names)
	beg := color + ToFmtStr(c.Opts.Denom, r.Decimals, spot, &r.BegBal)
	net := ToFmtStr(c.Opts.Denom, r.Decimals, spot, &r.AmountNet)
	end := ToFmtStr(c.Opts.Denom, r.Decimals, spot, &r.EndBal)
	if f(r.EndBal) == 0 {
		end = colors.BrightBlack + end
	}
	bigTotIn := big.Float{}
	bigTotIn.SetString(r.TotalIn)
	totIn := ToFmtStrFloat(c.Opts.Denom, r.Decimals, spot, r.TotalIn)
	gasOut := ToFmtStrFloat(c.Opts.Denom, r.Decimals, spot, r.GasOut)
	totOutLessGas := ToFmtStrFloat(c.Opts.Denom, r.Decimals, spot, r.TotalOutLessGas)
	sig := strings.Split(strings.Replace(strings.Replace(r.Signature, "{name:", "", -1), "}", "", -1), "|")[0]
	if len(sig) == 0 {
		sig = r.Encoding
	}
	sig = colors.White + sig
	if msg == "Summary" {
		sig = "---------------"
	}
	hash := color + r.TransactionHash.String()

	checks := map[bool]string{false: colors.Red + "x", true: colors.Green + "ok"}
	check := checks[r.Reconciled]

	var row string
	if msg == "Summary" {
		if c.Opts.Verbose > 1 {
			row = fmt.Sprintf(
				"%s\t\t\t\t\t%s\t%s\t%s\t%s\t\t\t\t\t\t\t%d\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t\t\t%s%s",
				msg,
				date,
				r.AccountedFor,
				symbol,
				asset,
				r.Decimals,
				denom,
				beg,
				net,
				end,
				totIn,
				gasOut,
				totOutLessGas,
				check,
				colors.Off)
		} else {
			row = fmt.Sprintf(
				"%s\t\t\t%s\t%s\t%s\t\t\t\t\t\t\t%d\t%s\t%s\t%s\t%s\t\t\t%s%s",
				msg,
				date,
				symbol,
				asset,
				r.Decimals,
				denom,
				beg,
				net,
				end,
				check,
				colors.Off)
		}
	} else {
		if c.Opts.Verbose > 1 {
			row = fmt.Sprintf(
				"%s\t%d\t%d\t%d\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%f\t%d\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s%s",
				msg,
				r.BlockNumber,
				r.TransactionIndex,
				r.LogIndex,
				hash,
				date,
				r.AccountedFor,
				symbol,
				asset,
				sender,
				recipient,
				r.PriceSource,
				r.SpotPrice,
				r.Decimals,
				denom,
				beg,
				net,
				end,
				totIn,
				gasOut,
				totOutLessGas,
				sig,
				r.ReconciliationType,
				check,
				colors.Off)
		} else {
			row = fmt.Sprintf(
				"%s\t%d\t%d\t%s\t%s\t%s\t%s\t%s\t%s\t%f\t%d\t%s\t%s\t%s\t%s\t%s\t%s\t%s%s",
				msg,
				r.BlockNumber,
				r.TransactionIndex,
				date,
				symbol,
				asset,
				sender,
				recipient,
				r.PriceSource,
				r.SpotPrice,
				r.Decimals,
				denom,
				beg,
				net,
				end,
				sig,
				r.ReconciliationType,
				check,
				colors.Off)
		}
	}
	fmt.Fprintf(c.w, "%s\n", row)
	c.w.Flush()
}

func (c *ProfitAndLoss) ReportHeader(verbose int, r *mytypes.RawReconciliation) {
	var fields []string
	if verbose > 1 {
		fields = []string{
			"type",
			"blockNumber",
			"transactionIndex",
			"logindex",
			"transactionHash",
			"date",
			"accountedFor",
			"assetSymbol",
			"assetAddress",
			"assetName",
			"sender",
			"senderName",
			"recipient",
			"recipientName",
			"priceSource",
			"spotPrice",
			"decimals",
			"denom",
			"begBal",
			"amountNet",
			"endBal",
			"totalIn",
			"gasOut",
			"totalOutLessGas",
			"function",
			"reconciliationType",
			"reconciled",
		}
	} else {
		fields = []string{
			"type",
			"blockNumber",
			"transactionIndex",
			"date",
			"assetSymbol",
			"assetAddress",
			"assetName",
			"sender",
			"senderName",
			"recipient",
			"recipientName",
			"priceSource",
			"spotPrice",
			"decimals",
			"denom",
			"begBal",
			"amountNet",
			"endBal",
			"function",
			"reconciliationType",
			"reconciled",
		}
	}
	for i, f := range fields {
		if i > 0 {
			fmt.Fprint(c.w, ",")
		}
		fmt.Fprint(c.w, f)
	}
	c.w.Write([]byte{'\n'})
	c.w.Flush()
}
