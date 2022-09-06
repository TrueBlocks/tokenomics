# Addresses

This data set contains two collections of data.

## Getting the data

In the present folder, create a new folder called `./store/`. Then,

```
curl -o store.tar.gz https://ipfs.unchainedindex.io/ipfs/
gunzip store.tar.gz
tar -xvf store.tar
rm -f store.tar
```

This should create the following files in the `./store` folder.

## ./store/addressesPerTransCount.csv

The first collection, `./store/addressesPerTransCount.csv` is a single file with two columns containing the following fields:

| name   | type | description                                                                                 |
| ------ | ---- | ------------------------------------------------------------------------------------------- |
| nAddrs | uint | The number of Ethereum mainnet addresses with exactly `nTxs` transactions in their history. |
| nTxs   | uint | The number of transactions in the address's history.                                        |

To create this file, we used the Unchained Index to scan the entire history of the Etheruem Mainnet. This
scan was conducted on October 24, 2021. During hte scan, we counted in how many transactions each address appeared.
The results of that scan are summarized in this file. For example, the first row of data

```
nAddrs,nTxs
52252394,1
```

indicates that 52,252,394 addresses had exactly one transaction at the time of this study. The last line in the file,

```
1,126556331
```

indicates that a single address (we don't know which) had 126,556,331 transactions at the time of this study.

There are 28,175 records in this file. My guess is that the data is "tri-modal" if that means anything.

Some preliminary charts are shown in the [attached spreadsheet](./nApps.xlsx).

## ./store/addressesPerTransCount.csv

An excel spreadsheet with a few preliminary charts.

## ./store/addressesNumberOfTransactions/

This folder contains the raw data used to produce the summary statistics. I don't suppose we will need to analyze this data directly.

It consists of 16 files (separated only in order to keep the size of each file smaller). There is one record for each address we found during the scan followed by the number of times that address appears in a transaction across its history.
