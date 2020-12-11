### Types of Reports

These are the higher level types of data we can collect (there are probably more--feel free to add):

| color | assessment |
| --- | --- |
| ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) | in scope and possible |
| ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) | out of scope (but possible) |
| ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) | doable but a little unclear |


#### Block / Transaction level
- Number of blocks/transactions/traces/logs per min/hour/day/week/month/10,000/100,000/1,000,000
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) whole chain
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) by monitor group
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) by monitored address
- Number of transactions/traces/logs per block
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) whole chain
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) for block `n`
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) by monitor group
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) by monitored address
- Number of traces/logs per transaction
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) whole chain
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) for block `n`
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) by monitor group
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) by monitored address
- Percentage of value transfers as contract executions vs. contract creations vs. suicides
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) whole chain
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) for block `n`
  - ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) for monitored addresses -- mostly doable, but need to get specific about surfacing suicide value
- Average 'input' data size per min/hour/day/week/month/10,000/100,000/1,000,000
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) all tx input data
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) monitored address tx input data
- Average value of transactions over time (including and excluding zero value transactions)
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) for all tx
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) for monitored address tx
- ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) Analysis of Eth bloom filters (how full, how many false positives?)

#### Account level
- New account creations per min/hour/day/week/month/10,000/100,000/1,000,000
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) scoped to whole chain
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) scoped to activity on monitored address(es)
- Total number of accounts (by regular vs. contract)
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) scoped to whole chain
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) scoped to monitored address(es)
- Percentages of regular accounts to smart contract accounts
  - Do we know whether account is externally owned account or contract account?
- Most active regular vs. smart contract
  - Do we know whether account is externally owned account or contract account?
- Largest holdings regular vs. smart contract
  - Do we know whether account is externally owned account or contract account?
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) scoped to whole chain
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) scoped to monitored address(es)
- Distribution by number of external transactions involved in
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) any address
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) monitored address
- Distribution by number of internal transactions initiated
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) any address
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) monitored address
- ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) Most active creator of smart contracts
- Size of contract storage per address
  - ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) doable but out of scope? (data in Contracts.csv?)
- Size of contract code per address
  - ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) doable but out of scope? (data in Contracts.csv?)
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Activity density (most active over day/week/month/year)
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Activity span (longest distance between first and most recent transaction)
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Average life span (average of first vs. most recent transaction)
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) History of first event account
- History of Genesis accounts
  - this is the account that created the smart contract, right?

#### Gas/Ether accounting
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Expenditures on gas per min/hour/day/week/month/10,000/100,000/1,000,000 (in Wei / Ether / US Dollars)
- Contract generating largest all-time gas usage
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) between all addresses
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) between monitored addresses
- Contract with highest per transaction gas cost
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) between all addresses
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) between monitored addresses
- Highest spending on gas by a single non-contract account (and by a smart contract)
- ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) between all addresses
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) between monitored addresses
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Highest costing individual function call
- Gas price history (Wei / Ether / US dollar)
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) for all blocks / tx
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) for monitored address blocks / tx
- gasUsed as percentage of gasAllowed (relative to gasPrice)
  - By gasAllowed, do you mean gasLimit (bullet below)
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) gasUsed as a percentage of gasLimit
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Expenditures on gas per day in US dollars
- Total transaction volume in US dollars by min/hour/day/week/month/10,000/100,000/1,000,000
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) any address
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) monitored address
- Percent of transaction with more than 21000 gas used (the default for a transfer)
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) all tx
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) monitored address tx
- Percent of transactions with non-default gas price
  - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) all tx
  - ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) monitored address tx

#### Individual account data (i.e. tokenomics)
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Individual history of transactions per account (or group of accounts)
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Gas analysis for individual smart contracts (gas used per function, etc)
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Per block accounting / reconciliation with node
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Extraction of articulated transactions (count by function call)
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Comparison between two (or more) different ERC20 tokens **(monitored ERC20 tokens only)**
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Cap tables for ERC20 tokens
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Analysis of ERC721 tokens
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Asset inventories for ERC721 tokens

#### Relationship data
- Number of totally isolated account pairs?
- Can we identify cliques of accounts?
- Can we identify types of contracts by their relationships with other accounts alone?
- Are there recognizable smart contract structures?

#### Mining data
- Cost of mining rewards in US dollars
- Unique miners overall
- Most frequent winner
- Number of unique new miners per week
- Can we find cliques between miners?

#### Quickblocks specific
- Performance analysis
- Usage of adaptive hierarchical blooms filters (size savings, false positives, etc)

### Other Data

Here is some other data that I've already collected. These are not high quality data.

1. [Contracts.csv](./Contracts.csv) - A list of all Ethereum contracts as of block 4,750,000 along with how many other contracts that contract deployed sorted by number of sub-contracts.

2. [Transactions.xlsx](./Transactions.xlsx) - Transactions per 50,000 blocks by nTraces to block 5,000,000

3. [Traces.xlsx](./Traces.xlsx) - Traces per 50,000 blocks by nTraces to block 5,000,000

4. [tokensByWeek.txt](./tokensByWeek.txt) - Token related transactions by week since inception  
    **fields:** blockNum, date, nBlocks, nTrans, nTraces, nTransfers, nApproves, nTransferFroms, nTTransfers, nTApproves, nTTransferFroms

5. [countsByWeek.txt](./countsByWeek.txt) - Counts related to full vs. empty blocks, transaction counts by week  
    **fields:** blockNum, date, nEmpty, nFull, pctFull, nTrans, tx/full blk, tx/all blks, nTraces

6. [countsPer10000.txt](./countsPer10000.txt) - Counts related to full vs. empty blocks, transaction counts by 10,000 blocks  
    **fields:** blockNum, date, nEmpty, nFull, pctFull, nTrans, tx/full blk, tx/all blks, nTraces

7. [countsPer10000.xlsx](./countsPer10000.xlsx) - Spreadsheet with same data

8. [AEBFilters.xlsx](./AEBFilters.xlsx) - Adaptive Enhanced Bloom Filters (charts)

9. [./other/forMax_aws/data/](./) - Every smart contract every created along with which account created it

### Various Graphics

<img src="./Blocks Per Week 09-08.png">

### Other source code (not in repo)

    ./other/gasHole/
    ./other/blockCheck/results
    ./other/blockCheck/data/
    ./other/blooms/research/data/
    ./other/blooms/tests/
    ./other/papers.save/
    ./other/traceCounter/data/
    ./other/bytesUsed/tests/
    ./other/valueCheck/
    ./other/ddos/
    ./other/inputSize/
    ./other/internal/tests/
    ./other/docs.save/
    ./other/fixBlocks/
    ./other/inerror/tests/
    ./other/tokenCounter/
    ./other/ddos2/
    ./other/visitor/
    ./other/bloomTester/
    ./other/tokenFactory/
    ./other/sortShit/
    ./other/db/data/
    ./other/bloomDao/tests/
    ./other/countBlocks/
    ./other/bitsTwiddled/
    ./other/miniBlkTst/data/
    ./other/acctIndex/data/
    ./apps/bloomMan/data/
