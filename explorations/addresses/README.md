# Addresses

This data captures the number of transactions each address on Ethereum Mainnet had been involved in by the date the data was extracted (Oct 23, 2021).

## Getting the data

To get a copy of the data set, complete these steps from the command line in the present folder:

```
curl -o store.tar.gz https://ipfs.unchainedindex.io/ipfs/QmcPKsPVkUEjsa3Y6gFbXik8PPaa3naJPyirfiWjGtcFFB
gunzip store.tar.gz
tar -xvf store.tar
rm -f store.tar
```

This should create two files in the `./store` folder.

## ./store/addressesPerTransCount.csv

The first file, `./store/addressesPerTransCount.csv` contains two columns of data, thus:

| name   | type | description                                                                                 |
| ------ | ---- | ------------------------------------------------------------------------------------------- |
| nAddrs | uint | The number of Ethereum mainnet addresses with exactly `nTxs` transactions in their history. |
| nTxs   | uint | The number of transactions in the address's history.                                        |

We used the [Unchained Index](https://unchainedindex.io) to scan the entire history of the Etheruem Mainnet. This
scan was conducted on October 23, 2021. During the scan, we counted the number of transactions each address appeared
in. The results of that scan are summarized in this file. For example, the first row of data

```
nAddrs,nTxs
52252394,1
```

indicates that 52,252,394 addresses participated in exactly one transaction in Ethereum's history. The last line in the file,

```
1,126556331
```

indicates that one address had 126,556,331 transactions at the time of the study.

There are 28,175 records in the file.

My guess is that the data is "tri-modal."

Some preliminary charts are shown in the [attached spreadsheet](./nApps.xlsx).

## ./store/nApps.xlsx

An excel spreadsheet containing a few preliminary charts.
