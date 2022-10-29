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
		if statement.passesFilter() {
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

func (s *internalStatement) passesFilter() bool {
	return s.AssetSymbol == "ETH"
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
	BlockNumber      uint64      `json:"blockNumber"`
	TransactionIndex uint64      `json:"transactionIndex"`
	TransactionHash  common.Hash `json:"transactionHash"`
	// Timestamp        uint64 `json:"timestamp"`
	Date        string         `json:"date"`
	Sender      common.Address `json:"sender"`
	Recipient   common.Address `json:"recipient"`
	AssetAddr   common.Address `json:"assetAddr"`
	AssetSymbol string         `json:"assetSymbol"`
	Decimals    uint64         `json:"decimals"`
	PrevBlk     uint64         `json:"prevBlock"`
	PrevBlkBal  float64        `json:"prevBal"`
	BegBal      float64        `json:"begBal"`
	EndBal      float64        `json:"endBal"`
	// AmountIn            big.Int `json:""`
	// InternalIn          big.Int `json:""`
	// SelfDestructIn      big.Int `json:""`
	// MinerBaseRewardIn   big.Int `json:""`
	// MinerNephewRewardIn big.Int `json:""`
	// MinerTxFeeIn        big.Int `json:""`
	// MinerUncleRewardIn  big.Int `json:""`
	// PrefundIn           big.Int `json:""`
	// AmountOut           big.Int `json:""`
	// InternalOut         big.Int `json:""`
	// SelfDestructOut     big.Int `json:""`
	// GasCostOut          big.Int `json:""`
	// SpotPrice           float64 `json:""`
	// PriceSource         string `json:""`
	// BegBalDiff          big.Int `json:""`
	// EndBalCalc          big.Int `json:""`
	// EndBalDiff          big.Int `json:""`
	TotalIn            float64 `json:"totalIn"`
	TotalOut           float64 `json:"totalOut"`
	TotalOutLessGas    float64 `json:"totalOutLessGas"`
	AmountNet          float64 `json:"amountNet"`
	Reconciled         bool    `json:"reconciled"`
	ReconciliationType string  `json:"reconcilationType"`
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
