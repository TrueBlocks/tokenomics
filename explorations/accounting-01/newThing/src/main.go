package main

import (
	accums "accounting/pkg/accumulators"
	"accounting/pkg/transformers"
	"accounting/pkg/types"
	"errors"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"strings"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/logger"
	"github.com/gocarina/gocsv"
)

// type IAccumulator interface {
// 	Accumulate(*RawReconciliation) bool
// }

// type Counter struct {
// 	Priced   map[string]uint64
// 	Unpriced map[string]uint64
// }

// func (c *Counter) Accumulate(r *RawReconciliation) bool {
// 	zero := big.NewFloat(0.0)
// 	if &r.SpotPrice != zero {
// 		c.Priced[r.AssetSymbol]++
// 	} else {
// 		c.Unpriced[r.AssetSymbol]++
// 	}
// 	return true
// }

//-------------------------------
// for i := 0; i < len(records); i++ {
// 		thing := strings.Replace(strings.Replace(records[i].Date, " UTC", "", -1), " ", "T", -1) + ".000000"
// 		date, _ := gostradamus.Parse(thing, gostradamus.Iso8601)
// 		y := fmt.Sprintf("%04d", date.Year())
// 		// m := fmt.Sprintf("%02d", date.Month())
// 		// d := fmt.Sprintf("%02d", date.Day())
// 		// key := records[i].AccountedFor + ":" + y + ":" + records[i].AssetAddress + ":" + fmt.Sprintf("%-5s", records[i].AssetSymbol)[:5]
// 		key := y + ":" + records[i].AccountedFor //  + ":" + fmt.Sprintf("%-5s", records[i].AssetSymbol)[:5]
// 		// fmt.Println(thing, date, err, key)
// 		// if records[i].SpotPrice.Cmp(Zero()) != 0 {
// 		if counter.Priced == nil {
// 			counter.Priced = make(map[string]uint64)
// 		}
// 		counter.Priced[key]++
// 		// counter.Priced["P-"+key]++
// 		// } else {
// 		// 	if counter.Unpriced == nil {
// 		// 		counter.Unpriced = make(map[string]uint64)
// 		// 	}
// 		// 	counter.Unpriced["U-"+key]++
// 		// }
// 		records[i].BegBalUsd = *utils.PriceUsd(records[i].BegBal, records[i].Decimals, &records[i].SpotPrice)
// 		records[i].AmountNetUsd = *utils.PriceUsd(records[i].AmountNet, records[i].Decimals, &records[i].SpotPrice)
// 		records[i].EndBalUsd = *utils.PriceUsd(records[i].EndBal, records[i].Decimals, &records[i].SpotPrice)
// 		// fmt.Println(records[i])
// 	}
// 	logger.Log(logger.Progress, "Processed ", first, " records")

// 	// arr := []string{}
// 	// for k, v := range counter.Priced {
// 	// 	arr = append(arr, fmt.Sprintf("%s:%d", k, v))
// 	// }

// 	// sort.Strings(arr)

// 	// fmt.Println()
// 	// last := ""
// 	// for _, l := range arr {
// 	// 	parts := strings.Split(l, ":")
// 	// 	if parts[0] != last {
// 	// 		fmt.Println()
// 	// 	}
// 	// 	fmt.Println(l)
// 	// 	last = parts[0]
// 	// }
// 	// // for k, v := range counter.Unpriced {
// 	// 	fmt.Println(k, v)
// 	// }
// }

// --------------------------------
func main() {
	folder := "./raw/statements/"

	accumulators := []accums.Accumulator[float64]{
		// &accums.Counter{},
		// &accums.Totaler{},
		// &accums.Averager{},
		// &accums.Min{Min: 4294967295.},
		// &accums.Max{},
	}

	reconAccumulators := []accums.Accumulator[*types.RawReconciliation]{
		// &accums.ReconCounter{},
		// &accums.ReconGrouper{},
		// &accums.TxCounter{},
		// &accums.ReconIdentity{},
		&accums.ReconBalances{},
	}

	transformers := []transformers.Transformer[*types.RawReconciliation]{
		&transformers.ReconPricer{},
	}

	filepath.Walk(folder, func(path string, info fs.FileInfo, err error) error {
		if !strings.HasSuffix(path, ".csv") || err != nil {
			return err
		}

		var theFile *os.File
		theFile, err = os.OpenFile(path, os.O_RDWR|os.O_CREATE, os.ModePerm)
		if err != nil {
			return err
		}
		defer theFile.Close()

		records := []*types.RawReconciliation{}
		if err := gocsv.UnmarshalFile(theFile, &records); err != nil {
			if !errors.Is(err, gocsv.ErrEmptyCSVFile) {
				logger.Log(logger.Error, colors.BrightYellow+"Path: "+path+colors.Off, err)
				return err
			}
			return nil
		}

		for _, r := range records {
			for _, t := range transformers {
				t.Transform(r)
			}
			for _, a := range accumulators {
				a.Accumulate(float64(r.BlockNumber))
			}
			for _, a := range reconAccumulators {
				a.Accumulate(r)
			}
		}
		return nil
	})

	for _, a := range accumulators {
		fmt.Println(a.Result())
	}

	for _, a := range reconAccumulators {
		fmt.Println(a.Result())
	}
}
