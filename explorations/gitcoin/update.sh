#!/usr/bin/env bash

rm -fR one two
mkdir -p one two

time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv                           >two/gitcoin-txs.csv
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv --logs                    >two/gitcoin-logs.csv
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv --receipts                >two/gitcoin-reciepts.csv
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv --traces                  >two/gitcoin-traces.csv
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv --accounting --statements >two/gitcoin-statements.csv
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv --neighbors               >two/gitcoin-neighbors.csv

diff -r one two >diff.fil 2>&2
echo -n nDiff:
wc diff.fil
cp -pf two/* one/
