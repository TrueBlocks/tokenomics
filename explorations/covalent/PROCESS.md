# Covalent / TrueBlocks Comparison

In this document, we discuss the process

## Preparing the list of addresses

## Getting the data

For each of 5,001 addresses, we did this:

| Script                                                                                                                      | Action                                                                                   | Fields Extracted...  | Result Stored In...                |
| --------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- | -------------------- | ---------------------------------- |
| [get\_from_covalent](https://github.com/TrueBlocks/tokenomics/blob/main/explorations/covalent/PROCESS.md#get_from_covalent) | Using Covalent API, query the address for all records<br>- pretty prints and zips result |                      | `./raw/covalent/$ADDR.json.gz`     |
| process_covalent                                                                                                            | Process results to extract fields<br>- clamps range to 3000000-14800000                  | `<hash> <bn> <txId>` | `./processed/covalent/$ADDR.txt`   |
|                                                                                                                             |                                                                                          |                      |                                    |
| get\_from_trueblocks                                                                                                        | Using TrueBlocks API, query the address for all records                                  |                      | `./raw/trueblocks/$ADDR.txt.gz`    |
| process_trueblocks                                                                                                          | Process results to extract fields<br>- clamps range to 3000000-14800000                  | `<hash> <bn> <txId>` | `./processed/trueblocks/$ADDR.txt` |

After the above four scripts have run, we have four files for each address. Two `.gz` files and two files containing `hash.bn.txId`.

## Comparing the results

Next, we post process the records looking for (a) records in Covalent but not in TrueBlocks; and (b) records in TrueBlocks but not in Covalent.

| Script       | Action                                                                                                                   | Result Stored In...                           |
| ------------ | ------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------- |
| post_process | Compares the corresponding files in<br>`./processed/...` and extracts records<br>returns by one system but not the other | `./diff/covalent_not_trueblocks/$ADDR.txt.gz` |
|              |                                                                                                                          | `./diff/trueblocks_not_covalent/$ADDR.txt.gz` |

## Listings

### get\_from_covalent

```[bash]
#!/usr/bin/env bash

echo
echo "------------------------------------------------------------------------------------------------------------"
echo "Running get_from_covalent"
echo "------------------------------------------------------------------------------------------------------------"

KEY=`cat .env`
if [ -z "$KEY" ]
then
    echo "Covalent API key not found. Put it in .env in this folder. Quitting..."
    exit
else
    echo "Covalent key found $KEY"
fi

if [ -z "$1" ]
then
    echo "Usage ./get_from_covalent <address>"
    exit
fi

echo "Downloading data from Covalent for $1"

# get covalent's version of the address's history
curl -X GET \
    "https://api.covalenthq.com/v1/1/address/$1/transactions_v2/?key=$KEY&page-size=5000" \
    -H "Accept: application/json" --output x

# format it and cleanup
cat x | jq >store/raw/covalent/$1.json
rm -f x

# zip it so it doesn't take up so much room
gzip -f -n store/raw/covalent/$1.json
```
