package accounting

import (
	"accounting/pkg/mytypes"
	"accounting/pkg/traverser"
	"accounting/pkg/utils"
	"fmt"
	"reflect"
	"sort"
	"strings"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
)

// --------------------------------
type AssetStatement struct {
	Opts   traverser.Options
	Values map[string]*mytypes.RawReconciliation
}

func (c *AssetStatement) Accumulate(r *mytypes.RawReconciliation) {
	if len(c.Values) == 0 {
		c.Values = make(map[string]*mytypes.RawReconciliation)
	}
	c.Values[c.GetKey(r)] = r
}

func (c *AssetStatement) GetKey(r *mytypes.RawReconciliation) string {
	return string(r.AssetAddress) + "_" + r.AssetSymbol
}

func (c *AssetStatement) Result() string {
	return c.Name() + "\n" + c.reportValues("Assets", c.Values)
}

func (c *AssetStatement) Name() string {
	return colors.Green + reflect.TypeOf(c).Elem().String() + colors.Off
}

func (c *AssetStatement) reportValues(msg string, m map[string]*mytypes.RawReconciliation) string {
	type stats struct {
		Address string
		Symbol  string
		Balance string
		Recon   *mytypes.RawReconciliation
	}
	hasPriced := 0
	hasNotPriced := 0
	zeroPriced := 0
	zeroNotPriced := 0

	arr := make([]stats, 0, len(m))
	for k, v := range m {
		parts := strings.Split(k, "_")
		stat := stats{Recon: v, Address: parts[0], Symbol: parts[1]}
		stat.Balance = ToFmtStr(c.Opts.Denom, v.Decimals, v.SpotPrice, &v.EndBal)
		arr = append(arr, stat)
		hasUnits := v.EndBal.Cmp(utils.Zero()) != 0
		priced := v.SpotPrice > 0
		if hasUnits && priced {
			hasPriced++
		} else if hasUnits && !priced {
			hasNotPriced++
		} else if !hasUnits && priced {
			zeroPriced++
		} else if !hasUnits && !priced {
			zeroNotPriced++
		}
	}
	sort.Slice(arr, func(i, j int) bool {
		if arr[i].Recon.EndBal.Cmp(&arr[j].Recon.EndBal) == 0 {
			return arr[i].Address < arr[j].Address
		}
		return arr[i].Recon.EndBal.Cmp(&arr[j].Recon.EndBal) < 0
	})

	ret := fmt.Sprintf("Number of %s: %d\n", msg, len(c.Values))

	ret += ExportHeader("Non-Zero Units Priced", hasPriced)
	ret += "Date,Asset,Symbol,Price Source,Spot Price,Uints,Usd\n"
	for _, val := range arr {
		hasUnits := val.Recon.EndBal.Cmp(utils.Zero()) != 0
		priced := val.Recon.SpotPrice > 0
		if hasUnits && priced {
			ret += fmt.Sprintf("%s,%s,%s,%s,%f,%s\n", val.Recon.Date.String(), val.Address, val.Symbol, val.Recon.PriceSource, val.Recon.SpotPrice, val.Balance)
		}
	}

	ret += ExportHeader("Non-Zero Units Unpriced", hasNotPriced)
	ret += "Date,Asset,Symbol,Price Source,Spot Price,Uints,Usd\n"
	for _, val := range arr {
		hasUnits := val.Recon.EndBal.Cmp(utils.Zero()) != 0
		priced := val.Recon.SpotPrice > 0
		if hasUnits && !priced {
			ret += fmt.Sprintf("%s,%s,%s,%s,%f,%s\n", val.Recon.Date.String(), val.Address, val.Symbol, val.Recon.PriceSource, val.Recon.SpotPrice, val.Balance)
		}
	}

	ret += ExportHeader("Zero Units Priced", zeroPriced)
	ret += "Date,Asset,Symbol,Price Source,Spot Price,Uints,Usd\n"
	for _, val := range arr {
		hasUnits := val.Recon.EndBal.Cmp(utils.Zero()) != 0
		priced := val.Recon.SpotPrice > 0
		if !hasUnits && priced {
			ret += fmt.Sprintf("%s,%s,%s,%s,%f,%s\n", val.Recon.Date.String(), val.Address, val.Symbol, val.Recon.PriceSource, val.Recon.SpotPrice, val.Balance)
		}
	}

	ret += ExportHeader("Zero Units Unpriced", zeroNotPriced)
	ret += "Date,Asset,Symbol,Price Source,Spot Price,Uints,Usd\n"
	for _, val := range arr {
		hasUnits := val.Recon.EndBal.Cmp(utils.Zero()) != 0
		priced := val.Recon.SpotPrice > 0
		if !hasUnits && !priced {
			ret += fmt.Sprintf("%s,%s,%s,%s,%f,%s\n", val.Recon.Date.String(), val.Address, val.Symbol, val.Recon.PriceSource, val.Recon.SpotPrice, val.Balance)
		}
	}

	return ret
}
