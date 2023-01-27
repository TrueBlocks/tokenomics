#!/usr/bin/env bash

echo
echo "--------------------------------------------------------------------------------"
echo "Processing $1..."
chifra export --fmt csv --articulate --cache $1 >raw/txs/$1.csv
wc raw/txs/$1.csv
chifra export --fmt csv --accounting --statements $1 >raw/statements/$1.csv
wc raw/statements/$1.csv
cat raw/statements/$1.csv | cut -f6 -d, | cut -f2 -d'"' | cut -f1 -d'-' | sort | uniq -c | sort -n
