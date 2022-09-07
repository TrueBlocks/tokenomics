# Covalent / TrueBlocks Comparison

This study is intended to show some of the many significant advantages one can realize using TrueBlocks over other methods of blockchain data extraction. These advantages include:

1. Speed - TrueBlocks is much faster than traditional APIs,
2. Accuracy - TrueBlocks is (currently) more accurate than other APIs,
3. Privacy - TrueBlocks runs locally on your machine, therefore there is no possibility of privacy invasion,
4. Flexibility - TrueBlocks is programmable and presents a large number of options.

We completed this study using TrueBlocks running locally on a "beefy" Mac laptop. This laptop was also running an Erigon Ethereum Mainnet node locally. We use the Covalent APIs described in [this documentation](https://www.covalenthq.com/docs/api/#/0/Get%20transactions%20for%20address/USD/1) to extract the corresponding Covalent data. The Covalent endpoint was running remotely and is likely being shared by other users and therefore rate-limited.

# Data pipeline

A detailed description of [the data pipeline used is here](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/PROCESS.md).

# Speed - TrueBlocks is faster

## Extraction from Covalent

Here we present the amount of time that was needed to extract effectively the same data from the two sources. Note that in the case of Covalent, we had to slow down the processing otherwise our requests would time out. This is the downside of sharing an API server with others.

| source     | addresses | elapsed minutes | elapsed time | addresses / minute |
| ---------- | --------- | --------------- | ------------ | ------------------ |
| Covalent   | 5000      | 743.31 mins     | 12.3 hours   | 6.7                |
| TrueBlocks | 5000      | 336.29          | 5.6 hours    | 14.9               |

**Upshot:** TrueBlocks is more than twice as fast even though it's running on a laptop.

# Accuracy - TrueBlocks is more accurate

|           | Covalent  | TrueBlocks | Description                                                                |
| --------- | --------- | ---------- | -------------------------------------------------------------------------- |
| count     | 5,000     | 5,000      | We processed this many addresses...                                        |
| different | -         | 3,174      | - this many addresses had records that were in TrueBlocks but not Covalent |
| material  | -         | 1,133      | - this many addresses had missing transactions that were "material".       |
|           |           |            |                                                                            |
| count     | 1,336,508 | 1,534,997  | The endpoint returneded this many transactional records...                 |
| different | -         | 198,489    | ...this many more were returned by TrueBlocks...                           |
| material  | -         | 45,328     | ...of which this many had material change in ETH balance.                  |

**Upshot:** TrueBlocks is more accurate. It, quite literally, finds more data. In the above table, "material" means that one of the missing transactions contained a change in the ETH balance for the account. This is why accounting doesn't work on Ethereum Mainnet. You can't accurately account for something if you're missing data.

## What's missing?

We studied the list of transactions that were missing from Covalent. We found 253 different "known" transaction types with TrueBlocks but not Covalent. Additionally, we found 183 different
unknown transction types (i.e. unknown four-bytes values) missing function calls representing 41,483 and 3,845 transactions respectively.

The top 15 "known" function calls were:

| Function                  | Count      | Percent | Cumulative  |
| ------------------------- | ---------- | ------- | ----------- |
| donate                    | 29746      | 71.7%   | 71.7%       |
| purchase                  | 840        | 2.0%    | 73.7%       |
| mintBuilding              | 796        | 1.9%    | 75.7%       |
| bid                       | 775        | 1.9%    | 77.5%       |
| contract-deployment       | 696        | 1.7%    | 79.2%       |
| mintBatch                 | 689        | 1.7%    | 80.9%       |
| assembleUnicorn           | 646        | 1.6%    | 82.4%       |
| buyOrIncreaseContribution | 586        | 1.4%    | 83.8%       |
| getFreeShrimp             | 584        | 1.4%    | 85.2%       |
| execute                   | 481        | 1.2%    | 86.4%       |
| buy                       | 472        | 1.1%    | 87.5%       |
| adminWithdraw             | 410        | 1.0%    | 88.5%       |
| placeBid                  | 326        | 0.8%    | 89.3%       |
| execTransaction           | 298        | 0.7%    | 90.0%       |
| withdraw                  | 239        | 0.6%    | 90.6%       |
|                           |            |         |             |
| **Total**                 | **41,483** | **-**   | **100.00%** |

Purusing that table, it becomes relatively easy to see why accounting doesn't work on Ethereum Mainnet. Most of these function names have a clear monitary value assocaited with the name.

# Sources of Error

## Predominance of GitCoin-related addresses in the dataset

A large proportion of the addresses we studied have interacted with (by either being a recipient or sending a donation) on GitCoin. For this reason, a large proportion of the missing transacitons are 'dontate' (71%). While it is accurate to say that TrueBlocks found these transactions but Covalent didn't, and Covelent could, if they wish, add this four-byte signature to their special processing list, TrueBlocks finds this transaciton without such a list. In other words, we look at everything regardless of its meaning. If the address appears on the chain for any reason, we find it. We call this the "Long Tail Problem." By this, we mean we do not want to create a "list" of know behaviour becuase such a list invariably excludes the "long tail of creativity" that the blockchain engenders.

**Upshot:** Our data may skew towards a certain type of address.

## Misuse of Covalent APIs

We did our best to study the Covalent APIs but we may have missed something. Please let us know if we did. This public API may not deliver exactly the same data as certain for-pay APIs (but this is a bad thing). Also, we limited out data set to those records that had less than 5,000 transactions as of the date of our study. While TrueBlocks easily handles addresses with more than 5,000 transactions due to the utter lack of rate limiting. We did this because Covalent has rate limiting and if we asked for address with more than 5,000 we had two problems: (1) Covalent was too slow to be practicable, (2) we would assumed we would have been banned from their site.

**Upshot:** We may have misused the Covalent APIs.

## Block range limit

Even if one of the addresses in our study had transactions prior to block 3,000,000 or after 14,800,000, we removed these records. While it would have been totally fair to keep the transactions prior to block 3,000,000 we find that Covalent
has chosen to remove a large collection of transactions that happened during the 2016 dDos attack on Ethereum. This is justfieable is those transactions had no "matieral" value. If we had included those records, the results of this study
would have been significantly more in favor of TrueBlocks.

**Upshot:** Older and some newer block ranges were ignored in this study.

## Only studied addresses with less than 5,000 records

For similar issues, we chose to remove from our study any address with more than 5,000 records. Again, while TrueBlocks could have easily handled this many records, Covalent may have rate limited us, so we chose not to include those addresses. In this particular case of very large data sets, Covalent may outperform us (ignoring rate limiting). TrueBlocks is better at mid-sized to small data sets.

**Upshot:** If you're sharing a node, you're going to get rate limited.

## Using this repo

1. Get a Covalent API key, and put it in a file called .env in the local folder.
2. Run `./init` to create folders and build a simple tool (requires go language version 1.18 or later).
3. Add your list of addresses to the file `./download` calling into `./download.1` for each address (we build this script with `cat` and `sed` by piping `./addresses.txt`)
4. The results will be placed in appropriate-named subfolders in local folder called `./store`.

## Obtaining the data

The data may be recreated if you have (a) a Covalent API key, (b) a locally-running version of the TrueBlocks command line tools, and (b) a day or two to wait. See the [data pipeline](./PROCESS.md) document for more information.

Alternatively, you may download the data into the `store` folder from IPFS using these commands:

```
curl -o store.tar.gz "https://ipfs.unchainedindex.io/ipfs/QmQK2mEmNNjJe6neWMjHeBaQdvDiGrNYTP7KU93s3oBWym"
gzunip store.tar.gz
tar -xvf store.tar
rm -f store.tar
```