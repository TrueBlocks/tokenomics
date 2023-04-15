==> gitcoin-txs.csv <==

https://trueblocks.io/data-model/chaindata/#transaction

| Field            | Description                                                        | Type      |
| ---------------- | ------------------------------------------------------------------ | --------- |
| blockNumber      | the number of the block                                            | blknum    |
| transactionIndex | the zero-indexed position of the transaction in the block          | blknum    |
| date             | teh date of the transaction                                        | datetime  |
| timestamp        | the Unix timestamp of the transaction                              | timestamp |
| from             | address from which the transaction was sent                        | address   |
| to               | address to which the transaction was sent                          | address   |
| ether            | the amount of ether sent with this transactions                    | float     |
| etherGasPrice    | the number of ether per unit of gas the sender is willing to spend | float     |
| gasUsed          | the maximum number of gas used by this transaction                 | gas       |
| hash             | The hash of the transaction                                        | hash      |
| isError          | true if the transaction ended in error, false otherwise            | uint8     |
| encoding         | the first four bytes of the input data                             |
| compressedTx     | truncated, more readable version of the articulation               | string    |

==> gitcoin-logs.csv <==

https://trueblocks.io/data-model/chaindata/#log

| Field            | Description                                                                                       | Type      |
| ---------------- | ------------------------------------------------------------------------------------------------- | --------- |
| blockNumber      | the number of the block                                                                           | blknum    |
| transactionIndex | the zero-indexed position of the transaction in the block                                         | blknum    |
| logIndex         | the zero-indexed position of this log relative to the block                                       | blknum    |
| transactionHash  | the hash of the transction                                                                        | hash      |
| timestamp        | the timestamp of the block this log appears in                                                    | timestamp |
| address          | the smart contract that emitted this log                                                          | address   |
| topics           | The first topic hashes event signature of the log, up to 3 additional index parameters may appear | topic[]   |
| data             | any remaining un-indexed parameters to the event                                                  | bytes     |
| compressedLog    | a truncated, more readable version of the articulation                                            | string    |

==> gitcoin-reciepts.csv <==

https://trueblocks.io/data-model/chaindata/#receipt

| Field            | Description                                                          | Type   |
| ---------------- | -------------------------------------------------------------------- | ------ |
| blockNumber      |                                                                      | blknum |
| transactionIndex |                                                                      | blknum |
| transactionHash  |                                                                      | hash   |
| status           | 1 on transaction suceess, null if tx preceeds Byzantium, 0 otherwise | uint32 |
| gasUsed          | the amount of gas actually used by the transaction                   | gas    |
| isError          |                                                                      | bool   |

==> gitcoin-traces.csv <==

https://trueblocks.io/data-model/chaindata/#trace

| Field            | Description                                               | Type      |
| ---------------- | --------------------------------------------------------- | --------- |
| blockNumber      | the number of the block                                   | blknum    |
| transactionIndex | the zero-indexed position of the transaction in the block | blknum    |
| traceAddress     | a particular trace’s address in the trace tree            | string[]  |
| subtraces        | the number of children traces that the trace hash         | uint64    |
| action::callType | the type of call                                          | string    |
| error            | if present, the reason for the error                      | string    |
| action::from     | address from which the trace was sent                     | address   |
| action::to       | address to which the trace was sent                       | address   |
| action::value    |                                                           |           |
| action::ether    |                                                           |           |
| action::gas      | the maximum number of gas allowed for this trace          | gas       |
| result::gasUsed  | the amount of gas used by this trace                      | gas       |
| action::input    |                                                           |           |
| compressedTrace  | a compressed string version of the articulated trace      | string    |
| result::output   | the result of the call of this trace                      | bytes     |
| timestamp        | the timestamp of the block                                | timestamp |

==> gitcoin-statements.csv <==

https://trueblocks.io/data-model/accounts/#reconciliation

| Field               | Description                                                                                                                                   | Type      |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| blockNumber         | the number of the block                                                                                                                       | blknum    |
| transactionIndex    | the zero-indexed position of the transaction in the block                                                                                     | blknum    |
| logIndex            | the zero-indexed position the log in the block, if applicable                                                                                 | blknum    |
| transactionHash     | the hash of the transaction that triggered this reconciliation                                                                                | hash      |
| timestamp           | the Unix timestamp of the object                                                                                                              | timestamp |
| date                | a calculated field – the date of this transaction                                                                                             | datetime  |
| assetAddr           | 0xeeee…eeee for ETH reconciliations, the token address otherwise                                                                              | address   |
| assetSymbol         | either ETH, WEI, or the symbol of the asset being reconciled as extracted from the chain                                                      | string    |
| decimals            | The value of decimals from an ERC20 contract or, if ETH or WEI, then 18                                                                       | uint64    |
| spotPrice           | The on-chain price in USD (or if a token in ETH, or zero) at the time of the transaction                                                      | double    |
| priceSource         | The on-chain source from which the spot price was taken                                                                                       | string    |
| accountedFor        | the address being accounted for in this reconciliation                                                                                        | address   |
| sender              | the initiator of the transfer (the sender)                                                                                                    | address   |
| recipient           | the receiver of the transfer (the recipient)                                                                                                  | address   |
| begBal              | the beginning balance of the asset prior to the transaction                                                                                   | int256    |
| amountNet           | a calculated field – totalIn - totalOut                                                                                                       | int256    |
| endBal              | the on-chain balance of the asset (see notes about intra-block reconciliations)                                                               | int256    |
| encoding            | The topic of the event (if this is an ERC20 reconcilation), the four-byte signature of the transaction otherwise                              | string    |
| signature           | If possible, the articulated name of the function or event signature                                                                          | string    |
| reconciliationType  | One of regular, prevDiff-same, same-nextDiff, or same-same. Appended with eth or token                                                        | string    |
| reconciled          | a calculated field – true if endBal === endBalCalc and begBal === prevBal. false otherwise.                                                   | bool      |
| totalIn             | a calculated field – the sum of the following In fields                                                                                       | int256    |
| amountIn            | the top-level value of the incoming transfer for the accountedFor address                                                                     | int256    |
| internalIn          | the internal value of the incoming transfer for the accountedFor address                                                                      | int256    |
| selfDestructIn      | the incoming value of a self-destruct if recipient is the accountedFor address                                                                | int256    |
| minerBaseRewardIn   | the base fee reward if the miner is the accountedFor address                                                                                  | int256    |
| minerNephewRewardIn | the nephew reward if the miner is the accountedFor address                                                                                    | int256    |
| minerTxFeeIn        | the transaction fee reward if the miner is the accountedFor address                                                                           | int256    |
| minerUncleRewardIn  | the uncle reward if the miner who won the uncle block is the accountedFor address                                                             | int256    |
| prefundIn           | at block zero (0) only, the amount of genesis income for the accountedFor address                                                             | int256    |
| totalOut            | a calculated field – the sum of the following Out fields                                                                                      | int256    |
| amountOut           | the amount (in units of the asset) of regular outflow during this transaction                                                                 | int256    |
| internalOut         | the value of any internal value transfers out of the accountedFor account                                                                     | int256    |
| selfDestructOut     | the value of the self-destructed value out if the accountedFor address was self-destructed                                                    | int256    |
| gasOut              | if the transaction’s original sender is the accountedFor address, the amount of gas expended                                                  | int256    |
| totalOutLessGas     | a calculated field – totalOut - gasOut                                                                                                        | int256    |
| prevAppBlk          | the block number of the previous appearance, or 0 if this is the first appearance                                                             | blknum    |
| prevBal             | the account balance for the given asset for the previous reconciliation                                                                       | int256    |
| begBalDiff          | a calculated field – difference between expected beginning balance and balance at last reconciliation, if non-zero, the reconciliation failed | int256    |
| endBalDiff          | a calculated field – endBal - endBalCalc, if non-zero, the reconciliation failed                                                              | int256    |
| endBalCalc          | a calculated field – begBal + amountNet                                                                                                       | int256    |

