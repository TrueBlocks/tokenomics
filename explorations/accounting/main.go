package main

import (
	"accounting/pkg/mytypes"
	"accounting/pkg/traverser"
	"accounting/pkg/traverser/accounting"
	"accounting/pkg/traverser/logs"
	"accounting/pkg/traverser/stats"
	"errors"
	"fmt"
	"io/fs"
	"log"
	"os"
	"path/filepath"
	"strconv"
	"strings"

	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/colors"
	"github.com/TrueBlocks/trueblocks-core/src/apps/chifra/pkg/logger"

	"github.com/gocarina/gocsv"
)

// --------------------------------
func main() {
	rootFolder, _ := os.Getwd()

	addressFn := filepath.Join(rootFolder, "addresses.csv")
	if !FileExists(addressFn) {
		log.Println(Usage("{0} not found.", addressFn))
		os.Exit(0)
	}

	summaryFolder := filepath.Join(rootFolder, "/summary/")
	if !FolderExists(summaryFolder) {
		log.Println(Usage("{0}} not found.", summaryFolder))
		os.Exit(0)
	}

	opts := traverser.GetOptions(addressFn)
	statTraversers := stats.GetTraversers(opts)
	reconTraversers := accounting.GetTraversers(opts)
	logTraversers := logs.GetTraversers(opts)

	filepath.Walk(summaryFolder, func(path string, info fs.FileInfo, err error) error {
		isRecon := strings.Contains(path, "all_recons.csv")
		isLog := strings.Contains(path, "all_logs.csv")

		if !isRecon && !isLog {
			return nil
		}

		var theFile *os.File
		theFile, err = os.OpenFile(path, os.O_RDWR|os.O_CREATE, os.ModePerm)
		if err != nil {
			return err
		}
		defer theFile.Close()

		log.Println("Reading file", path)
		if isRecon {
			recons := []*mytypes.RawReconciliation{}
			if err := gocsv.UnmarshalFile(theFile, &recons); err != nil {
				if !errors.Is(err, gocsv.ErrEmptyCSVFile) {
					logger.Log(logger.Error, colors.BrightYellow+"Path: "+path+colors.Off, err)
					return err
				}
				return nil
			}

			log.Println(colors.Yellow+"Loaded", len(recons), "recons from", path, colors.Off)
			for _, r := range recons {
				for _, a := range statTraversers {
					a.Traverse(float64(r.BlockNumber))
				}
				for _, a := range reconTraversers {
					a.Traverse(r)
				}
			}
		} else if isLog {
			logs := []*mytypes.RawLog{}
			if err := gocsv.UnmarshalFile(theFile, &logs); err != nil {
				if !errors.Is(err, gocsv.ErrEmptyCSVFile) {
					logger.Log(logger.Error, colors.BrightYellow+"Path: "+path+colors.Off, err)
					return err
				}
				return nil
			}

			log.Println(colors.Yellow+"Loaded", len(logs), "logs from", path, colors.Off)
			for _, l := range logs {
				for _, a := range logTraversers {
					a.Traverse(l)
				}
			}
		} else {
			log.Panic("Should never get here")
		}

		return nil
	})

	for _, a := range statTraversers {
		fmt.Println(a.Result())
	}

	for _, a := range reconTraversers {
		fmt.Println(a.Result())
	}

	for _, a := range logTraversers {
		fmt.Println(a.Result())
	}
}

func FileExists(filename string) bool {
	info, err := os.Stat(filename)
	if os.IsNotExist(err) {
		return false
	}
	return !info.IsDir()
}

func FolderExists(path string) bool {
	info, err := os.Stat(path)
	if os.IsNotExist(err) {
		return false
	}
	return info.IsDir()
}

func Usage(msg string, values ...string) error {
	ret := msg
	for index, val := range values {
		rep := "{" + strconv.FormatInt(int64(index), 10) + "}"
		ret = strings.Replace(ret, rep, val, -1)
	}
	return errors.New(ret)
}
