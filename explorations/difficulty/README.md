# Using this repo

These instructions assume that you've cloned this repo, you have RStudio installed on your machine, and that your command line 
is currently in the folder containing this README file (./explorations/difficuly).

---
First, download the data to the current folder:

```
curl --output difficulty.csv.gz https://gateway.pinata.cloud/ipfs/QmdmkCJ7iRbmSLJzhEq3Cg6cPQj3oFStvAoE3G1rbhgmUw
```

Next, unzip the downloaded file:

```
gunzip difficulty.csv.gz
```

Next, move the data to where it belongs:

```
mkdir -p store/difficulty/
mv difficulty.csv store/difficulty
```

Finally, open the R script:

```
open difficulty.R
```

# Contributing

We're more than happy to get issues and PRs on either the data or the scripts in this folder. Please add issues here: https://github.com/TrueBlocks/tokenomics/issues.
