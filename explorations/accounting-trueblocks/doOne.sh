#!/usr/bin/env bash

echo
echo "--------------------------------------------------------------------------------"
echo "Processing $1..."

# chifra monitors --decache $1

chifra export --fmt csv --articulate --cache $1 >raw/txs/$1.csv
wc raw/txs/$1.csv

chifra export --fmt csv --articulate --accounting --statements $1 >raw/recons/$1.csv
wc raw/recons/$1.csv

chifra export --fmt csv --articulate --logs $1 >raw/logs/$1.csv
wc raw/logs/$1.csv

cat raw/recons/$1.csv | cut -f6 -d, | cut -f2 -d'"' | cut -f1 -d'-' | sort | uniq -c | sort -n

cat raw/recons/$1.csv | \
    sed 's/\",\"/\"@\"/g' | \
    sed 's/\\\"//g' | \
    tr ',' ' ' | \
    tr ' ' '_' | \
    tr '@' '\t' | \
    awk '{print $7,$8,$12,$6,$1,$2,$3,$4,$15,$16,$17,$18,$19,$10,$11,$5,$9,$13,$14,$21}' | \
    tr ' ' ',' | \
    tr '_' ' ' | \
    grep -v assetAddr >>summary/all_recons.csv
cat raw/logs/$1.csv | grep -v blockNumber >>summary/all_logs.csv

