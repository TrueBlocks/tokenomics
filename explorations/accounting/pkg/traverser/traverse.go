package traverser

import (
	"accounting/pkg/mytypes"
	"bufio"
	"log"
	"os"
	"strings"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/names"
	"github.com/ethereum/go-ethereum/common"
)

type Traverser[T mytypes.RawType] interface {
	Traverse(t T)
	GetKey(t T) string
	Result() string
	Name() string
}

type Options struct {
	Period  string
	Denom   string
	Verbose int
	Filters map[mytypes.Address]bool
	Names   names.NamesMap
}

func GetOptions(addressFn string) Options {
	ret := Options{}
	if len(os.Args) > 1 {
		for i, a := range os.Args {
			if i > 0 {
				if a == "--nocolor" {
					colors.ColorsOff()
				} else if a == "--verbose" {
					ret.Verbose++
				} else if a == "units" || a == "usd" || a == "wei" {
					ret.Denom = a
				} else if mytypes.IsValidPeriod(a) {
					ret.Period = a
				}
			}
		}
	}

	ret.Names, _ = names.LoadNamesMap("mainnet")
	ret.Names[common.HexToAddress("0x")] = names.Name{Name: "Creation/Mint"}
	log.Println(colors.Yellow+"Loaded", len(ret.Names), "names...", colors.Off)

	lines := AsciiFileToLines(addressFn)
	for _, line := range lines {
		if len(line) > 0 {
			parts := strings.Split(line, ",")
			if len(parts) > 2 {
				name := names.Name{}
				name.Tags = parts[0]
				name.Address = parts[1]
				name.Name = parts[2]
				ret.Names[common.HexToAddress(name.Address)] = name
				// log.Println(len(ret.Names), name)
				// log.Println()
			}
		}
	}
	log.Println(colors.Yellow+"Loaded", len(lines), "addresses...", colors.Off)

	lines = AsciiFileToLines("/Users/jrush/Development/tokenomics/explorations/accounting-01/filter.csv")
	if len(lines) > 0 {
		ret.Filters = make(map[mytypes.Address]bool)
		for _, line := range lines {
			ret.Filters[mytypes.Address(line)] = true
		}
	}
	log.Println(colors.Yellow+"Loaded", len(lines), "filters...", colors.Off)

	return ret
}

func AsciiFileToLines(filename string) []string {
	file, err := os.OpenFile(filename, os.O_RDONLY, 0)
	if err != nil {
		return []string{}
	}
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)
	var ret []string
	for scanner.Scan() {
		ret = append(ret, scanner.Text())
	}
	file.Close()
	return ret
}
