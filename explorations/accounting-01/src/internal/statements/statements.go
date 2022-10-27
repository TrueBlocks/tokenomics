package statements

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strconv"

	"github.com/ethereum/go-ethereum/common"
	"github.com/spf13/cobra"
)

func RunStatements(cmd *cobra.Command, args []string) {
	address := common.HexToAddress(args[0])
	statements := ReadStatements(address)
	first := true
	fmt.Println("[")
	for _, statement := range statements {
		if statement.AssetAddr == "0x1f9840a85d5af5bf1d1762f925bdaddc4201f984" {
			s := statement.ToStatement()
			if first {
				first = false
			} else {
				fmt.Println(",")
			}
			fmt.Printf("%s", s.String())
		}
	}
	fmt.Println("]")
}

type internalStatement struct {
	BlockNumber      uint64 `json:"blockNumber"`
	TransactionIndex uint64 `json:"transactionIndex"`
	// Timestamp        uint64 `json:"timestamp"`
	Sender      string `json:"sender"`
	Recipient   string `json:"recipient"`
	AssetAddr   string `json:"assetAddr"`
	AssetSymbol string `json:"assetSymbol"`
	Decimals    uint64 `json:"decimals"`
	PrevBlk     uint64 `json:"prevBlk"`
	PrevBlkBal  string `json:"prevBlkBal"`
	BegBal      string `json:"begBal"`
	EndBal      string `json:"endBal"`
	// AmountIn            string  `json:"amountIn"`
	// InternalIn          string  `json:"internalIn"`
	// SelfDestructIn      string  `json:"selfDestructIn"`
	// MinerBaseRewardIn   string  `json:"minerBaseRewardIn"`
	// MinerNephewRewardIn string  `json:"minerNephewRewardIn"`
	// MinerTxFeeIn        string  `json:"minerTxFeeIn"`
	// MinerUncleRewardIn  string  `json:"minerUncleRewardIn"`
	// PrefundIn           string  `json:"prefundIn"`
	// AmountOut           string  `json:"amountOut"`
	// InternalOut         string  `json:"internalOut"`
	// SelfDestructOut     string  `json:"selfDestructOut"`
	// GasCostOut          string  `json:"gasCostOut"`
	// SpotPrice           float64 `json:"spotPrice"`
	// PriceSource         string  `json:"priceSource"`
	// ReconciliationType  string  `json:"reconciliationType"`
	// BegBalDiff          string  `json:"begBalDiff"`
	// EndBalCalc          string  `json:"endBalCalc"`
	// EndBalDiff          string  `json:"endBalDiff"`
	TotalIn         string `json:"totalIn"`
	TotalOut        string `json:"totalOut"`
	TotalOutLessGas string `json:"totalOutLessGas"`
	AmountNet       string `json:"amountNet"`
	Reconciled      bool   `json:"reconciled"`
	TransactionHash string `json:"transactionHash"`
	Date            string `json:"date"`
}

type Statement struct {
	BlockNumber      uint64
	TransactionIndex uint64
	TransactionHash  common.Hash
	// Timestamp        uint64
	Date        string
	Sender      common.Address
	Recipient   common.Address
	AssetAddr   common.Address
	AssetSymbol string
	Decimals    uint64
	PrevBlk     uint64
	PrevBlkBal  float64
	BegBal      float64
	EndBal      float64
	// AmountIn            big.Int
	// InternalIn          big.Int
	// SelfDestructIn      big.Int
	// MinerBaseRewardIn   big.Int
	// MinerNephewRewardIn big.Int
	// MinerTxFeeIn        big.Int
	// MinerUncleRewardIn  big.Int
	// PrefundIn           big.Int
	// AmountOut           big.Int
	// InternalOut         big.Int
	// SelfDestructOut     big.Int
	// GasCostOut          big.Int
	// SpotPrice           float64
	// PriceSource         string
	// BegBalDiff          big.Int
	// EndBalCalc          big.Int
	// EndBalDiff          big.Int
	TotalIn         float64
	TotalOut        float64
	TotalOutLessGas float64
	AmountNet       float64
	// Reconciled is true if the statement is reconciled, false otherwise.
	Reconciled         bool
	ReconciliationType string
}

func (s *Statement) String() string {
	bytes, _ := json.MarshalIndent(s, "", "  ")
	return string(bytes)
}

func (s *internalStatement) ToStatement() Statement {
	return Statement{
		BlockNumber:      s.BlockNumber,
		TransactionIndex: s.TransactionIndex,
		// Timestamp:        s.Timestamp,
		Date:        s.Date,
		Sender:      common.HexToAddress(s.Sender),
		Recipient:   common.HexToAddress(s.Recipient),
		AssetAddr:   common.HexToAddress(s.AssetAddr),
		AssetSymbol: s.AssetSymbol,
		Decimals:    s.Decimals,
		PrevBlk:     s.PrevBlk,
		PrevBlkBal:  ToFloat(s.PrevBlkBal),
		BegBal:      ToFloat(s.BegBal),
		EndBal:      ToFloat(s.EndBal),
		// AmountIn:            ToFloat(s.AmountIn),
		// InternalIn:          ToFloat(s.InternalIn),
		// SelfDestructIn:      ToFloat(s.SelfDestructIn),
		// MinerBaseRewardIn:   ToFloat(s.MinerBaseRewardIn),
		// MinerNephewRewardIn: ToFloat(s.MinerNephewRewardIn),
		// MinerTxFeeIn:        ToFloat(s.MinerTxFeeIn),
		// MinerUncleRewardIn:  ToFloat(s.MinerUncleRewardIn),
		// PrefundIn:           ToFloat(s.PrefundIn),
		// AmountOut:           ToFloat(s.AmountOut),
		// InternalOut:         ToFloat(s.InternalOut),
		// SelfDestructOut:     ToFloat(s.SelfDestructOut),
		// GasCostOut:          ToFloat(s.GasCostOut),
		// SpotPrice:           s.SpotPrice,
		// PriceSource:         s.PriceSource,
		// ReconciliationType:  s.ReconciliationType,
		// BegBalDiff:          ToFloat(s.BegBalDiff),
		// EndBalCalc:          ToFloat(s.EndBalCalc),
		// EndBalDiff:          ToFloat(s.EndBalDiff),
		TotalIn:         ToFloat(s.TotalIn),
		TotalOut:        ToFloat(s.TotalOut),
		TotalOutLessGas: ToFloat(s.TotalOutLessGas),
		AmountNet:       ToFloat(s.AmountNet),
		Reconciled:      s.Reconciled,
		TransactionHash: common.HexToHash(s.TransactionHash),
	}
}

func ToFloat(s string) float64 {
	f, _ := strconv.ParseFloat(s, 64)
	// n := new(big.Int)
	// n.SetString(s, 10)
	// return *n
	return f
}

func ReadStatements(address common.Address) []internalStatement {
	path := filepath.Join("/Users", "jrush", "Development", "tokenomics", "explorations", "accounting-01", "monitors", "exports", "mainnet", "statements", "no_data", address.Hex()+".json")
	// fmt.Println(path)
	ff, err := os.Open(path)
	if err != nil {
		log.Fatal(err)
	}
	defer ff.Close()

	// contents := file.AsciiFileToString(path)
	// fmt.Println(contents)

	statements := []internalStatement{}
	err = json.NewDecoder(ff).Decode(&statements)
	if err != nil {
		log.Fatal(err)
	}

	return statements
}
