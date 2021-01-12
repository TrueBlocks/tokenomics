# Using this repo

These instructions assume you have RStudio installed on your machine and that your command line is currently in the folder containing this README file.

First, download the data to the local folder (copy the following as a single line):

```
curl --output difficulty.csv.gz https://gateway.pinata.cloud/ipfs/QmdmkCJ7iRbmSLJzhEq3Cg6cPQj3oFStvAoE3G1rbhgmUw
```

Unzip the downloaded file:

```
gunzip difficulty.csv.gz
```

Move it to its correct location:

```
mkdir -p store/difficulty/
mv difficulty.csv store/difficulty
```

Open the R script:

```
open difficulty.R
```

# Contributing

We're more than happy to get issues and PRs on either the data or the scripts in this folder. Please add issues here: https://github.com/TrueBlocks/tokenomics/issues.
