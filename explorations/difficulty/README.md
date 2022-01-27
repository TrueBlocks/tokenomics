# Investigating Ethereum Difficulty Data

These instructions assume that you've cloned this repo, you have RStudio installed on your machine, and that your command line 
is currently in the folder containing this README file (./explorations/difficuly).

---
First, download the data to the current folder:

```
curl --output difficulty.csv.gz https://gateway.pinata.cloud/ipfs/QmWbdS1dcQZjYBDLaB7jmRet6fQMNPaN4R1bxcoopQHb8K
```

Next, unzip the downloaded file:

```
gunzip difficulty.csv.gz
```

Finally, open the R script (you may have to edit the path to the data)

```
open difficulty.R
```

# Contributing

We're more than happy to get issues and PRs on either the data or the scripts in this folder. Please add issues here: https://github.com/TrueBlocks/tokenomics/issues.
