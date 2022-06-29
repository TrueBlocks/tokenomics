# Covalent / TrueBlocks Comparison

In this document, we discuss the data pipeline we built to accomplish the study.

## Preparing the list of addresses

The first task was to collect together a list of randomly selected addresses. We did this by running this command:

```
chifra names
```

This command returns 12,925 addresses that we (TrueBlocks) has collected over the years from various sources. We selected 5,001 of these addresses randomly.

## Getting the data

For each of 5,001 addresses, we did this:

| Script                                       | Action                                                                                      | Fields Extracted...  | Result Stored In...                |
| -------------------------------------------- | ------------------------------------------------------------------------------------------- | -------------------- | ---------------------------------- |
| [get_from_covalent](./get_from_covalent)     | Using Covalent API, query the address for all records<br>- pretty print and zip the results |                      | `./raw/covalent/$ADDR.json.gz`     |
| [process_covalent](./process_covalent)       | Process results to extract fields<br>- clamps range to 3000000-14800000                     | `<hash> <bn> <txId>` | `./processed/covalent/$ADDR.txt`   |
|                                              |                                                                                             |                      |                                    |
| [get_from_trueblocks](./get_from_trueblocks) | Using TrueBlocks API, query the address for all records                                     |                      | `./raw/trueblocks/$ADDR.txt.gz`    |
| [process_trueblocks](./process_trueblocks)   | Process results to extract fields<br>- clamps range to 3000000-14800000                     | `<hash> <bn> <txId>` | `./processed/trueblocks/$ADDR.txt` |

After the above four scripts have run, we have four files for each address. Two `.gz` files and two files containing `hash.bn.txId`.

## Comparing the results

Next, we post process the records looking for (a) records in Covalent but not in TrueBlocks; and (b) records in TrueBlocks but not in Covalent.

| Script                         | Action                                                                                                                   | Result Stored In...                           |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------- |
| [post_process](./post_process) | Compares the corresponding files in<br>`./processed/...` and extracts records<br>returns by one system but not the other | `./diff/covalent_not_trueblocks/$ADDR.txt.gz` |
|                                |                                                                                                                          | `./diff/trueblocks_not_covalent/$ADDR.txt.gz` |

## All Listings

| Name                                                                                                                | Description                                                             | command                        |
| ------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- | ------------------------------ |
| [init](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/init)                               | Creates the needed subfolder structure for storing results              | ./init                         |
|                                                                                                                     |                                                                         |                                |
| [download](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/download)                       | calls `./download.1` on each address                                    | ./download                     |
| [download.1](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/download.1)                   | calls `get_from*`, `process_*` and `post_process` for each address      | ./download.1 `<addr>`          |
|                                                                                                                     |                                                                         |                                |
| [get_from_covalent](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/get_from_covalent)     | calls Covalent API and zips results into `raw` folder                   | ./get_from_covalent `<addr>`   |
| [get_from_trueblocks](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/get_from_trueblocks) | calls TrueBlocks command line and zips results into `raw` folder        | ./get_from_trueblocks `<addr>` |
|                                                                                                                     |                                                                         |                                |
| [process_covalent](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/process_covalent)       | extracts relevant fields from downloaded data, clamps block range       | don't run directly             |
| [process_trueblocks](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/process_trueblocks)   | extracts relevant fields from downloaded data, clamps block range       | don't run directly             |
|                                                                                                                     |                                                                         |                                |
| [post_process](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/post_process)               | diff the two processed files for the address and called `diff_datasets` | don't run directly             |
| [diff_datasets](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/diff_datasets)             | compares the two datasets and stores results in `diff` folders          | don't run directly             |
|                                                                                                                     |                                                                         |                                |
| [stats](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/stats)                             | standalone: produces summary statistics (calls other `stats` scripts)   | ./stats                        |
| [stats.1](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/stats.1)                         | internal: creates summary of function calls and four-bytes              | don't run directly             |
| [stats.2](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/stats.2)                         | internal: creates summary of function calls and four-bytes              | don't run directly             |
| [stats.raw](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/stats.raw)                     | internal: creates summaries for raw folder                              | don't run directly             |
