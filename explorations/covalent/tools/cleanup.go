package main

import (
    "fmt"
    "os"
    "strings"

    "github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/file"
)

func main() {

    fileName := "./store/" + os.Args[1] + "/" + os.Args[2] + ".txt"
    lines := file.AsciiFileToLines(fileName)
    for _, line := range lines {
        parts := strings.Split(line, "\t")
        ltTenMil := len(parts[1]) < 8
        gtThreeMil := ltTenMil && parts[1][:0] > "2"
        if (ltTenMil && gtThreeMil) || !strings.HasPrefix(parts[1], "148") {
            fmt.Println(line)
        }
    }
}
