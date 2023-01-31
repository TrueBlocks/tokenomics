#!/usr/bin/env bash

echo building $1...
accounting $1 ether --verbose --nocolor >results/txs_$1.csv
rm -f results/txs_$1.csv.gz
gzip -q results/txs_$1.csv
