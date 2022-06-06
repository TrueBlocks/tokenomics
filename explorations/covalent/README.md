# Covalent / TrueBlocks Comparison

This study is intended to show a few of the quite significant advantages to using TrueBlocks to extract transactional histories
for any Ethereum address, which include:

1. Speed
2. Accuracy
3. Privacy
4. Flexibility

# Using the repo

1. Put your covalent key in a file called .env
2. Run `./init` to create folders and build a simple tool (requires go 1.18 or later)
3. Add your addresses to the file ./download (the addresses we used are listed in ./addresses.txt)
4. All the results will be placed in appropriate-named subfolders in ./store

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

|            | Covalent | TrueBlocks | Difference | Description                                                             |
| ---------- | -------- | ---------- | ---------- | ----------------------------------------------------------------------- |
| test cases | 5,000    | 5,000      | -          | We processed this many addresses against both systems                   |
|            |          |            |            |                                                                         |
| received   | 609,092  | 707,559    | +98,467    | We received this many 'appearances' for those 5,000 addresses           |
|            |          |            |            |                                                                         |
| difference | -        | 1,426      | -          | This many addresses had more records in one system than the other...    |
|            | -        | 98,467     | -          | ...representing this many appearances                                   |
|            |          |            |            |                                                                         |
| material   | -        | 512        | -          | This many addresses had  material transactions missing from Covalent... |
|            | -        | 21,307     | -          | ...consisting of this many appearances                                  |

## What's missing?

There were 122 different known function calls missing and 106 different unknown (i.e. four-bytes) missing with 19,241 and 2,066 records respectivefully.

| Function                  | Count      | Percent | Cumulative  |
| ------------------------- | ---------- | ------- | ----------- |
| donate                    | 12447      | 64.69%  | 64.69%      |
| purchase                  | 802        | 4.17    | 68.86       |
| mintBuilding              | 796        | 4.14    | 73.00       |
| mintBatch                 | 685        | 3.56    | 76.56       |
| assembleUnicorn           | 646        | 3.36    | 79.91       |
| buyOrIncreaseContribution | 586        | 3.05    | 82.96       |
| buy                       | 434        | 2.26    | 85.21       |
| execute                   | 427        | 2.22    | 87.43       |
| bid                       | 270        | 1.40    | 88.84       |
| invoke1CosignerSends      | 202        | 1.05    | 89.89       |
| placeBid                  | 193        | 1.00    | 90.89       |
| swapToETH                 | 148        | 0.77    | 91.66       |
| execTransaction           | 131        | 0.68    | 92.34       |
| buyOffer                  | 128        | 0.67    | 93.00       |
| draw                      | 127        | 0.66    | 93.66       |
| acceptFulfillment         | 83         | 0.43    | 94.10       |
| buyoutAndSetReferrer      | 76         | 0.39    | 94.49       |
| withdraw                  | 74         | 0.38    | 94.88       |
| buyout                    | 70         | 0.36    | 95.24       |
| disperseEther             | 60         | 0.31    | 95.55       |
|                           |            |         |             |
| **Total**                 | **19,241** | **-**   | **100.00%** |

# Sources of Error

## Predominance of GitCoin related addresses in the dataset

A large proportion of the addresses we studied have interacted with (by either being 
a recipient or sending a donation) on GitCoin. For this reason, a large proportion of 
the missing transacitons are 'dontate'. While it is accurate to say that TrueBlocks
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
we had two problems: (1) too slow, (2) we would get banned from their site.

## Range limited

We limited the range of transactions to betwen 3,000,000 and 14,800,000 because
covalent does not provide any transactions in the range XXX to XXX which is
the Sept. 2016 dDos attack. If we had included these transactions, it would
have included over 29,000,000 additional records -- none of which had a material
effect.

## Only studied addresses with less than 5,000 records

Otherwise, Covalent would rate limit us and exclude us from their API.
Not your node, not your data!