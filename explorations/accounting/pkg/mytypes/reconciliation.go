package mytypes

import (
	"encoding/json"
	"math/big"

	"github.com/ethereum/go-ethereum/common"
)

type RawReconciliation struct {
	BlockNumber         uint64      `json:"blockNumber" csv:"blockNumber"`
	TransactionIndex    uint64      `json:"transactionIndex" csv:"transactionIndex"`
	LogIndex            uint64      `json:"logIndex" csv:"logIndex"`
	TransactionHash     common.Hash `json:"transactionHash" csv:"transactionHash"`
	Timestamp           int64       `json:"timestamp" csv:"timestamp"`
	Date                DateTime    `json:"date" csv:"date"`
	AssetAddress        Address     `json:"assetAddress" csv:"assetAddress"`
	AssetSymbol         string      `json:"assetSymbol" csv:"assetSymbol"`
	Decimals            uint64      `json:"decimals" csv:"decimals"`
	SpotPrice           float64     `json:"spotPrice" csv:"spotPrice"`
	PriceSource         string      `json:"priceSource" csv:"priceSource"`
	AccountedFor        Address     `json:"accountedFor" csv:"accountedFor"`
	Sender              Address     `json:"sender" csv:"sender"`
	Recipient           Address     `json:"recipient" csv:"recipient"`
	BegBal              big.Float   `json:"begBal" csv:"begBal"`
	AmountNet           big.Float   `json:"amountNet" csv:"amountNet"`
	EndBal              big.Float   `json:"endBal" csv:"endBal"`
	Encoding            string      `json:"encoding" csv:"encoding"`
	Signature           string      `json:"signature" csv:"signature"`
	ReconciliationType  string      `json:"reconciliationType" csv:"reconciliationType"`
	Reconciled          bool        `json:"reconciled" csv:"reconciled"`
	TotalIn             string      `json:"totalIn" csv:"totalIn"`
	AmountIn            string      `json:"amountIn,omitempty" csv:"amountIn"`
	InternalIn          string      `json:"internalIn,omitempty" csv:"internalIn"`
	SelfDestructIn      string      `json:"selfDestructIn,omitempty" csv:"selfDestructIn"`
	MinerBaseRewardIn   string      `json:"minerBaseRewardIn,omitempty" csv:"minerBaseRewardIn"`
	MinerNephewRewardIn string      `json:"minerNephewRewardIn,omitempty" csv:"minerNephewRewardIn"`
	MinerTxFeeIn        string      `json:"minerTxFeeIn,omitempty" csv:"minerTxFeeIn"`
	MinerUncleRewardIn  string      `json:"minerUncleRewardIn,omitempty" csv:"minerUncleRewardIn"`
	PrefundIn           string      `json:"prefundIn,omitempty" csv:"prefundIn"`
	TotalOut            string      `json:"totalOut" csv:"totalOut"`
	AmountOut           string      `json:"amountOut,omitempty" csv:"amountOut"`
	InternalOut         string      `json:"internalOut,omitempty" csv:"internalOut"`
	SelfDestructOut     string      `json:"selfDestructOut,omitempty" csv:"selfDestructOut"`
	GasOut              string      `json:"gasOut,omitempty" csv:"gasOut"`
	TotalOutLessGas     string      `json:"totalOutLessGas" csv:"totalOutLessGas"`
	PrevAppBlk          uint64      `json:"prevAppBlk,omitempty" csv:"prevAppBlk"`
	PrevBal             string      `json:"prevBal,omitempty" csv:"prevBal"`
	BegBalDiff          string      `json:"begBalDiff,omitempty" csv:"begBalDiff"`
	EndBalDiff          string      `json:"endBalDiff,omitempty" csv:"endBalDiff"`
	EndBalCalc          string      `json:"endBalCalc,omitempty" csv:"endBalCalc"`
}

func (r *RawReconciliation) String() string {
	bytes, _ := json.MarshalIndent(r, "", "  ")
	return string(bytes)
}

/*
	func (s *SimpleReconciliation) SetRaw(raw *RawReconciliation) {
		s.raw = raw
	}

	func (s *SimpleReconciliation) Model(showHidden bool, format string, extraOptions map[string]any) Model {
		// EXISTING_CODE
		// EXISTING_CODE

		model := map[string]interface{}{
			"blockNumber":         s.BlockNumber,
			"transactionIndex":    s.TransactionIndex,
			"logIndex":            s.LogIndex,
			"transactionHash":     s.TransactionHash,
			"timestamp":           s.Timestamp,
			"date":                s.Date,
			"assetAddr":           s.AssetAddr,
			"assetSymbol":         s.AssetSymbol,
			"decimals":            s.Decimals,
			"spotPrice":           s.SpotPrice,
			"priceSource":         s.PriceSource,
			"accountedFor":        s.AccountedFor,
			"sender":              s.Sender,
			"recipient":           s.Recipient,
			"begBal":              s.BegBal,
			"amountNet":           s.AmountNet,
			"endBal":              s.EndBal,
			"encoding":            s.Encoding,
			"signature":           s.Signature,
			"reconciliationType":  s.ReconciliationType,
			"reconciled":          s.Reconciled,
			"totalIn":             s.TotalIn,
			"totalOut":            s.TotalOut,
			"totalOutLessGas":     s.TotalOutLessGas,
		}

		order := []string{
			"blockNumber",
			"transactionIndex",
			"logIndex",
			"transactionHash",
			"timestamp",
			"date",
			"assetAddr",
			"assetSymbol",
			"decimals",
			"spotPrice",
			"priceSource",
			"accountedFor",
			"sender",
			"recipient",
			"begBal",
			"amountNet",
			"endBal",
			"encoding",
			"signature",
			"reconciliationType",
			"reconciled",
			"totalIn",
			"totalOut",
			"totalOutLessGas",
		}

		// EXISTING_CODE
		// EXISTING_CODE

		return Model{
			Data:  model,
			Order: order,
		}
	}

// EXISTING_CODE
// EXISTING_CODE
*/
