package types

import (
	"strings"
)

type Address string

func (a *Address) String() string {
	ret := strings.ToLower(string(*a))
	return ret
}

func (a *Address) UnmarshalCSV(csv string) (err error) {
	*a = *(*Address)(&csv)
	return nil
}
