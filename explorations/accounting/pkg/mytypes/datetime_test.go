package mytypes

import (
	"testing"
)

func TestDateTime(t *testing.T) {

	dt := DateTime{}
	err := dt.UnmarshalCSV("2020-11-30 00:53:46 UTC")
	if err != nil {
		t.Fatalf("dt.UnmarshalCSV() error should be nil")
	}

	str := dt.String()
	if str != "2020-11-30 00:53:46 +0000 UTC" {
		t.Fatalf("str should be 2020-11-30 00:53:46 +0000 UTC")
	}

	res, err := dt.MarshalCSV()
	if err != nil {
		t.Fatalf("dt.MarshalCSV() error should be nil")
	}
	if res != "2020-11-30 00:53:46 UTC" {
		t.Fatalf("dt.MarshalCSV() should be 2020-11-30 00:53:46 UTC")
	}
}
