package mytypes

import "encoding/json"

type RawLog struct {
	/*
	   "blockNumber","transactionIndex","logIndex","transactionHash","timestamp","address","topic0","topic1","topic2","topic3","data","compressedLog"
	*/
	Address          string `json:"address" csv:"address"`
	Topic0           string `json:"topic0" csv:"topic0"`
	Topic1           string `json:"topic1" csv:"topic1"`
	Topic2           string `json:"topic2" csv:"topic2"`
	Topic3           string `json:"topic3" csv:"topic3"`
	Data             string `json:"data" csv:"data"`
	BlockNumber      string `json:"blockNumber" csv:"blockNumber"`
	TransactionHash  string `json:"transactionHash" csv:"transactionHash"`
	TransactionIndex string `json:"transactionIndex" csv:"transactionIndex"`
	BlockHash        string `json:"blockHash" csv:"blockHash"`
	LogIndex         string `json:"logIndex" csv:"logIndex"`
	CompressedLog    string `json:"compressedLog" csv:"compressedLog"`
}

func (l *RawLog) String() string {
	bytes, _ := json.MarshalIndent(l, "", "  ")
	return string(bytes)
}
