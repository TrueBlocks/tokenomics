## Introduction

In this data exploration, we use TrueBlocks to extract "everything that ever happened" to a single address on Ethereum mainnet.

The address we've chosen for this study is the GitCoin smart contracts called the `OSS Round 17 Implementation` address. This address has approcimately 30,000 transactions in its history.

We will use a tool called `chifra`, which is the TrueBlocks command line tool. It gives access to all the sub-tools available through TrueBlocks.

TrueBlocks which is an indexing and data extraction tool being built by TrueBlocks, LLC. In the following document, we intersperse ideas about why we built TrueBlocks the way we did as well as the data as a way to help you understand our view of decentralized data access.

## Getting Started

I'm going to skip over how to get started with TrueBlocks in this article, so I have time to discuss how to use TrueBlocks assuming you already have it installed and it's running. The article also assumes you're running your own Ethereum node. We say this even though you can use a remote node such as Infura. We will detail the consequences of that choice below.

`chifra`

Run the following command:

```
chifra
```

You will get the following result:

```
Purpose:
  Access to all TrueBlocks tools (chifra <cmd> --help for more).

  Accounts:
    list          list every appearance of an address anywhere on the chain
    export        export full detail of transactions for one or more addresses
    monitors      add, remove, clean, and list address monitors
    names         query addresses or names of well known accounts
    abis          fetches the ABI for a smart contract
  Chain Data:
    blocks        retrieve one or more blocks from the chain or local cache
    transactions  retrieve one or more transactions from the chain or local cache
    receipts      retrieve receipts for the given transaction(s)
    logs          retrieve logs for the given transaction(s)
    traces        retrieve traces for the given transaction(s)
    when          find block(s) based on date, blockNum, timestamp, or 'special'
  Chain State:
    state         retrieve account balance(s) for one or more addresses at given block(s)
    tokens        retrieve token balance(s) for one or more addresses at given block(s)
  Admin:
    config        report on and edit the configuration of the TrueBlocks system
    status        report on the state of the internal binary caches
    daemon        initalize and control long-running processes such as the API and the scrapers
    scrape        scan the chain and update the TrueBlocks index of appearances
    chunks        manage, investigate, and display the Unchained Index
    init          initialize the TrueBlocks system by downloading from IPFS
  Other:
    explore       open a local or remote explorer for one or more addresses, blocks, or transactions
    slurp         fetch data from Etherscan for any address
  Flags:
    -h, --help    display this help screen

  Use "chifra [command] --help" for more information about a command.
```

Much like `git` or `ipfs`, `chifra` is a command line tool that contains (or gives you access to) a large number of other command line tools. In this article we will focus on only two of the commands: `list` and `export`. We start with `list`.

**chifra list**

Assuming you've properly installed TrueBlocks and have run `chifra init --all` or `chifra scrape`, you can run the following command:

```
chifra list --help
```

Note that every `chifra` subcommand carries it's own help file. Try this command:

```
chifra names oss round 17
```

you should get this result:

```
tags	address	name
31-Gitcoin:Core	0x746b951fa10a89d6cbe70d4ee23531f907b58bc0	Oss Round 17 Quadratic Funding
31-Gitcoin:Core	0xd95a1969c41112cee9a2c931e849bcef36a16f4c	Oss Round 17 Implementation
```

Let's use the second of these two address. Enter this command:

```
chifra list 0xd95a1969c41112cee9a2c931e849bcef36a16f4c
```

It returns a long list of 29,000 `<blockNumber><tx_id>` pairs. These are the address's "appearances." This is a list of every transaction in which this address appears for any reason (we will come back in a minute to what the reasons may be). With this list, you now have perfect access to the entirity of the data associated in any way with this address. Let's dig deeper.

**A short detour**

Enter

```
chifra export --help
```

This is the command for exporting the detailed transactional details of an address. Notice that there's a lot of different possibilities. Don't worry, we're going to spend a minute on each one.


**Getting transactions**

Enter

```
chifra export <address>
```

You will see a very fast scrolling list of tons of data. See the schema described below to see the various fields in this data. Let's change the output format. `chifra` allows you to export to one of three formats: `txt`, `csv`, or `json`. You can change the output format with the `--fmt` option. Let's make a csv file:

```
chifra export <address> --fmt csv
```

It takes a few minutes. This is because, unlike traditional API databases, TrueBlocks does not extract all the data from the node into a database and deliver that data through a database. We cannot do that because one of our primary design objectives was to make sure TrueBlocks runs on small machines (such as the laptop I am using right now to write this article). I'll try to explain below why it's not possible to pre-extract all the data on small machines.

**Cacheing**

While it is true that TrueBlocks must extract the data you request the first time you request it, it is not true that it has to do this every time you query. TrueBlocks has a built in binary cache that speeds up subsequent queries after the first one significantly. Enable to cache for any command by adding `--cache`, thus:

```
chifra export <address> --fmt csv --cache
```

We ran the above command on our computer with the work `time` in front of it (`time` chifra export...). The first run (without the cache) took 212.32 seconds to extract all 29,529 transactions (at the time of this writing). That's 139 queries per second. That is the speed of the node software's RPC endpoint. Our code runs as fast as it can against the RPC node. The same exact command run from the cache takes 9.65 seconds. A speedup of over 22 times. See the table below for the speedups. Upshot: if you have the disc space, use the `--cache` option. Things are much, much faster.

**Getting logs*


Let it run to completion -- 10 minutes

```
chifra export <address> --fmt csv --cache >gitcoin-txs.csv
```

10 seconds

```
chifra export <address> --logs --fmt csv >gitcoin-logs.csv
```

```
chifra export <address> --receipts --fmt csv >gitcoin-receipts.csv
```

```
chifra export <address> --traces --cache_traces --fmt csv >gitcoin-traces.csv
```

Repeat the idea of the cache. Make the point that trace and tx cache are different.

```
chifra export <address> --accounting --statements --fmt csv >gitcoin-statements.csv
```

Make the point about the cache again -- reconciliations is a different cache

```
chifra export <address> --neighbors --fmt csv >gitcoin-neighbors.csv
```

Make the point about the cache again - neighbors is a new cache

```
tar -cvf gitcoin.tar gitcoin
gzip gitcoin.tar
```

```
chifra publish --db_name gitcoin-12-31-2023 --db-schemas gitcoin/schemas --pinata
```

Needs to be published to the Unchained Index

Then anyone on the planet can do

```
ipfs get <hash> and have all this data
```




| Data Type  | nRecords | From Node | queries/sec |
| ---------- | -------- | --------- | ----------- |
| txs        | 29,529   | 212.32s   | 139.0       |
| logs       | 220,636  | 99.66s    | 2213.9      |
| receipts   | 29,529   | 94.65s    | 311.9       |
| traces     | 300,130  | 2460.63s  | 121.9       |
| statements | 29,529   | 6415.2s   | 4.6         |
| neighbors  | 328,981  | 323.17    | 1018.0      |


| Data Type  | nRecords | From Cache | queries/sec | # of times faster |
| ---------- | -------- | ---------- | ----------- | ----------------- |
| txs        | 29,529   | 9.65s      | 3060.0      | 22.01             |
| logs       | 220,636  | 21.04s     | 10486.5     | 4.74              |
| receipts   | 29,529   | 7.48s      | 3947.7      | 12.66             |
| traces     | 300,130  | 24.83s     | 12087.4     | 99.12             |
| statements | 29,529   | 11.73s     | 2517.4      | 546.91            |
| neighbors  | 328,981  | 35.17      | 9354.0      | 9.19              |


