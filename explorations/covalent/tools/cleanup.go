package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/file"
)

func main() {
	fileName := "./store/" + os.Args[1] + "/" + os.Args[2] + ".txt"
	lines := file.AsciiFileToLines(fileName)
	orig := len(lines)
	cnt := 0
	for _, line := range lines {
		parts := strings.Split(line, "\t")
		bn, err := strconv.ParseInt(parts[1], 10, 64)
		if err == nil {
			if bn >= 3000000 && bn < 14800000 {
				fmt.Println(line)
				cnt++
			}
		}
	}

	log.Println("Wrote", cnt, "lines out of", orig)
}
