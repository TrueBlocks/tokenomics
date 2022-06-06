# Covalent / TrueBlocks Comparison

Using this repo:

1. Put your covalent key in a file called .env
2. Run `./init` to create folders and build a simple tool (requires go 1.18 or later)
3. Add your addresses to the file ./download (the addresses we used are listed in ./addresses.txt)
4. All the results will be placed in appropriate-named subfolders in ./store

# Performance

## Covalent Extraction

```
1,249 files extracted between
    10:38 pm and 11:09 pm on May 28, 2020 - 31 minutes
     5:24 am and  5:47 pm on May 29, 2020 - 12 hours 23 minutes
    total: 12 hours 54 minutes - 0.619695756605284 minutes per address
                                37.181745396317040 seconds per address (probably invalid data)

3,752 files extracted between
    5:29 pm and 11:20 pm on Jun 5 - 5 hours 51 minutes
    total: 5 hours 51 minutes - 0.093550106609808 minutes per address
                                5.613006396588486 seconds per address (includes one second sleep)
```

The second one is way more accurate.

## Trueblocks Extraction

```
126.91 minutes for un-cached - 2 hours 6.91 minutes
5,001 records - 0.025376924615077 minutes per address
                1.522615476904619 seconds per address
```

# Statistics

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
