#!/usr/bin/env bash

mkdir -p data/all
mkdir -p data/txs

echo "---- Getting all data -------"
giveth data purple-verified --fmt csv  >data/all/all.csv
giveth data not-eligible    --fmt csv | grep -v "\"type\",\"round\",\"amount\"" >>data/all/all.csv
giveth data eligible        --fmt csv | grep -v "\"type\",\"round\",\"amount\"" >>data/all/all.csv

echo "---- Getting tx hashes -------"
cat data/all/all.csv                  | cut -d, -f7-9 | cut -f2,4,6 -d'"' | tr '"' ',' | grep -v txHash >data/txs/all.csv
giveth data purple-verified --fmt csv | cut -d, -f7-9 | cut -f2,4,6 -d'"' | tr '"' ',' | grep -v txHash >data/txs/purple-verified.csv
giveth data not-eligible    --fmt csv | cut -d, -f7-9 | cut -f2,4,6 -d'"' | tr '"' ',' | grep -v txHash >data/txs/not-eligible.csv
giveth data eligible        --fmt csv | cut -d, -f7-9 | cut -f2,4,6 -d'"' | tr '"' ',' | grep -v txHash >data/txs/eligible.csv

cat data/all/all.csv | head -1

# chifra transactions --uniq --file data/txs/all.csv
