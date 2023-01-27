package types

import (
	"strings"
	"time"
)

type DateTime struct {
	time.Time
}

func (dt *DateTime) String() string {
	ret := dt.Time.Format("2006-01-02T15:04:05")
	ret = strings.Replace(ret, "T", " ", -1)
	ret = strings.Replace(ret, "+0000", "", -1)
	return ret + " UTC"
}

func (dt *DateTime) MarshalCSV() (string, error) {
	return dt.String(), nil
}

func (dt *DateTime) UnmarshalCSV(csv string) (err error) {
	csv = strings.Replace(csv, " UTC", "", -1)
	csv = strings.Replace(csv, " ", "T", -1)
	fmt := strings.Replace(time.RFC3339, "Z07:00", "", -1)
	dt.Time, err = time.Parse(fmt, csv)
	return err
}

func (dt *DateTime) Year() int {
	return dt.Time.Year()
}
