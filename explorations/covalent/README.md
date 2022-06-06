# Covalent / TrueBlocks Comparison

This study is intended to show a few of the significant advantages one would realize from using TrueBlocks
to extract transactional histories for any Ethereum address. These advantages include:

1. Speed - TrueBlocks is much faster
2. Accuracy - TrueBlocks is much more accurate
3. Privacy - TrueBlocks runs locally, therefore there is no possibility of privacy invasion
4. Flexibility - TrueBlocks is programmable and presents many options

# Data pipeline

A detailed description of [the data pipeline is here](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/PROCESS.md).

# Performance

## Extraction from Covalent

| started       | ended   | elapsed        | addresses | seconds per address                            |
| ------------- | ------- | -------------- | --------- | ---------------------------------------------- |
| 4:53am May 29 | 5:47am  | 12 hrs 54 mins | 1,249     | 37.18 secs / addr (probably invalid)           |
| 5:29pm Jun 5  | 11:20pm | 5 hrs 51 mins  | 3,752     | 5.61 secs per addr (includes one second sleep) |

## Extraction from Trueblocks

| started      | ended  | elapsed      | addresses | seconds per address |
| ------------ | ------ | ------------ | --------- | ------------------- |
| 1:31am Jun 5 | 3:39am | 2 hrs 7 mins | 5,001     | 1.52 secs / addr    |

# Summary of results

|            | Covalent  | TrueBlocks | Description                                                                |
| ---------- | --------- | ---------- | -------------------------------------------------------------------------- |
| test cases | 5,001     | 5,001      | We processed this many addresses against both systems...                   |
| difference | -         | 3,174      | This many addresses had more records from TrueBlocks than from Covalent... |
| material   | -         | 1,133      | This many addresses with missing records had missing "material" records.   |
|            |           |            |                                                                            |
| received   | 1,336,508 | 1,534,997  | The endpoint returneds this many records...                                |
| difference | -         | 198,489    | ...representing this many appearances...                                   |
| material   | -         | 45,328     | ...of which this many had material change in ETH balance.                  |

## What's missing?

There were 253 different known material function calls missing from Covalent. Additionally, there were 183 different
unknown (i.e. four-bytes) missing function calls representing 41,483 and 3,845 transactions respectively.

The top 15 known function calls were:

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

# Sources of Error

## Predominance of GitCoin-related addresses in the dataset

A large proportion of the addresses we studied have interacted with (by either being 
a recipient or sending a donation) on GitCoin. For this reason, a large proportion of 
the missing transacitons are 'dontate' (71%). While it is accurate to say that TrueBlocks
found these transactions but Covalent didn't, and Covelent could, if they wish, add
this four-byte signature to their special processing list, TrueBlocks finds this
transaciton without such a list -- the long tail problem.

## Misuse of Covalent APIs

We did our best to study the Covalent APIs and found XYZ. This public API may not
deliver exactly the same data as certain for-pay APIs (but this is a bad thing).
Also, we limited out data set to those records that had less than 5,000 transactions
as of the date of our study. While TrueBlocks easily handles addresses with more
than 5,000 transactions due to the utter lack of rate limiting. We did this
because Covalent has rate limiting and if we asked for address with more than 5,000
we had two problems: (1) Covalent was too slow to be practicable, (2) we would
assumed we would have been banned from their site.

## Block range limit

Even if one of the addresses had transactions prior to block 3,000,000 or
after 14,800,000, we removed these records. While it would have been totally
fair to keep the transactions prior to block 3,000,000 we find that Covalent
has chosen to remove a large collection of transactions that happened during the
2016 dDos attack on Ethereum. This is justfieable is those transactions had no
"matieral" value. If we had included those records, the results of this study
would have been significantly more in favor of TrueBlocks.

## Only studied addresses with less than 5,000 records

FOr similar issues, we chose to remove from our study any address with more than
5,000 records. Again, while TrueBlocks could have easily handled this many records,
Covalent may have rate limited us, so we chose not to include those addresses.

Upshot: Not your node, not your data!

# Using this repo

1. Put your covalent key in a file called .env
2. Run `./init` to create folders and build a simple tool (requires go 1.18 or later)
3. Add your addresses to the file ./download (the addresses we used are listed in ./addresses.txt)
4. All the results will be placed in appropriate-named subfolders in ./store

