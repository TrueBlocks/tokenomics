package utils

import (
	"fmt"
	"math/big"
	"testing"
)

func TestPricing(t *testing.T) {
	a := big.NewFloat(1.0)
	b := big.NewFloat(2.0)
	c := big.NewFloat(3.0)
	if a.Cmp(b) != -1 {
		t.Error("a should be less than b")
	}
	if b.Cmp(c) != -1 {
		t.Error("b should be less than c")
	}
	if a.Cmp(c) != -1 {
		t.Error("a should be less than c")
	}

	cc, _ := c.Uint64()
	z := pow(b, cc)
	if z.Cmp(big.NewFloat(8.0)) != 0 {
		t.Error("usd should be 8.0")
	}

	usd := PriceUsd("100", 2, big.NewFloat(1.))
	fmt.Println(usd, big.NewFloat(1.0), usd.Cmp(big.NewFloat(1.0)) == 0)
	if usd.Cmp(big.NewFloat(1.0)) != 0 {
		t.Error("usd should be 1.0")
	}
	usd = PriceUsd("1000", 2, big.NewFloat(1.))
	fmt.Println(usd, big.NewFloat(10.0), usd.Cmp(big.NewFloat(10.0)) == 0)
	if usd.Cmp(big.NewFloat(10.0)) != 0 {
		t.Error("usd should be 10.0")
	}

	usd = PriceUsd("123456789012345678", 18, big.NewFloat(1.))
	expected := NewDollars("0.123456789012345678")
	fmt.Println(usd, expected, usd.Cmp(expected) == 0)
	if usd.Cmp(expected) != 0 {
		t.Error("usd should be 1.010101010101011234")
	}

	usd = PriceUsd("123456789012345678", 18, big.NewFloat(2.))
	expected = NewDollars("0.246913578024691356")
	fmt.Println(usd, expected, usd.Cmp(expected) == 0)
	if usd.Cmp(expected) != 0 {
		t.Error("usd should be 1.010101010101011234")
	}

	usd = PriceUsd("123456789012345678", 18, big.NewFloat(.5))
	expected = NewDollars("0.061728394506172839")
	fmt.Println(usd, expected, usd.Cmp(expected) == 0)
	if usd.Cmp(expected) != 0 {
		t.Error("usd should be 1.010101010101011234")
	}
}

func NewDollars(dollars string) *big.Float {
	usd := big.NewFloat(0)
	usd.SetMode(big.ToNearestEven)
	usd.SetPrec(62) // gives us 19 digits of precision
	usd.SetString(dollars)
	return usd
}
