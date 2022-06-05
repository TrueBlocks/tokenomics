Sources of Error

Predominance of GitCoin related addresses in the dataset

A large proportion of the addresses we studied have interacted with (by either being 
a recipient or sending a donation) on GitCoin. For this reason, a large proportion of 
the missing transacitons are 'dontate'. While it is accurate to say that TrueBlocks
found these transactions but Covalent didn't, and Covelent could, if they wish, add
this four-byte signature to their special processing list, TrueBlocks finds this
transaciton without such a list -- the long tail problem.

Misuse of Covalent APIs

We did our best to study the Covalent APIs and found XYZ. This public API may not
deliver exactly the same data as certain for-pay APIs (but this is a bad thing).
Also, we limited out data set to those records that had less than 5,000 transactions
as of the date of our study. While TrueBlocks easily handles addresses with more
than 5,000 transactions due to the utter lack of rate limiting. We did this
because Covalent has rate limiting and if we asked for address with more than 5,000
we had two problems: (1) too slow, (2) we would get banned from their site.

Range limited
We limited the range of transactions to betwen 3,000,000 and 14,800,000 because
covalent does not provide any transactions in the range XXX to XXX which is
the Sept. 2016 dDos attack. If we had included these transactions, it would
have included over 29,000,000 additional records -- none of which had a material
effect.
