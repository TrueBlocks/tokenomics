## Task

Find all holders of

- for Uniswap LP token: https://etherscan.io/token/0xee3b01b2debd3df95bf24d4aacf8e70373113315
- for Sushiswap LP token: https://etherscan.io/token/0x60cd8dcc7cce0cca6a3743727ce909b6f715b2d8

at block 15854548 for both mainnet and gnosis.

## Method

- Download and initalize TrueBlocks
- Run the scraper to bring the index up to date
  - `chifra scrape`
  - when it's caught up, you can kill it
- Verify that the index is at or after the block you're interested in
  - `chifra status --terse`
  - all numbers should be at or past your block
- Make a folder called `./monitors`, 
  - `mkdir monitors && cd monitors`
- Create a file called `addresses.tsv` containing the token address (or addresses) you're interested in
- Create a file called `commands.fil` containing the following line:

```[shell]
export --ether --articulate --fmt json --cache
export --ether --logs  --fmt json --articulate --relevant
```

- Run the monitor (once):
  - `RUN_ONCE=true chifra monitors --watch`

- Extract a list of every address that has either sent or received the token (note this is any address that has ever held the token, not current holders)

```[shell]
#!/usr/bin/env bash

mkdir -p exports/mainnet/summaries

echo Summarizing $1...

echo "recordId,assetAddr,blockNumber,transactionIndex,date,transactionHash,sender,recipient" \
    >exports/mainnet/summaries/$1.csv

cat exports/mainnet/statements/$1.json | jq \
    '.data[] | "\(.assetAddr),\(.blockNumber),\(.transactionIndex),\(.date),\(.transactionHash),\(.sender),\(.recipient)"' \
    | sed 's/"//g' \
    | grep -n 0x \
    | sed 's/:/,/' \
    >>exports/mainnet/summaries/$1.csv
```

- Cut the senders and receivers into a single file

```[bash]
cut -d, -f7,8 monitors/export/mainnet/summaries/<address>.csv | tr ',' '\n' | sort -u >export/mainnet/all_time_holders/<address>.txt
```