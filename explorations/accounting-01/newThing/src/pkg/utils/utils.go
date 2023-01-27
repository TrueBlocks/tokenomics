package utils

import "math/big"

func PriceUsd(amtInt string, decimals uint64, spotPrice *big.Float) *big.Float {
	amount, _ := new(big.Float).SetString(amtInt)
	ten := new(big.Float)
	ten = ten.SetFloat64(10)
	divisor := pow(ten, decimals)
	units := zero().Quo(amount, divisor)
	usd := zero().Mul(units, spotPrice)
	usd.SetMode(big.ToNearestEven)
	usd.SetPrec(62) // gives us 19 digits of precision
	return usd
}

func pow(a *big.Float, e uint64) *big.Float {
	result := zero().Copy(a)
	for i := uint64(0); i < e-1; i++ {
		result = zero().Mul(result, a)
	}
	return result
}

func zero() *big.Float {
	r := big.NewFloat(0.0)
	r.SetPrec(256)
	return r
}
