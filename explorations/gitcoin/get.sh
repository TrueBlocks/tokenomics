#!/usr/bin/env bash

rm -fR one two
mkdir -p one two

chifra monitors --decache 0xd95a1969c41112cee9a2c931e849bcef36a16f4c
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv                           >one/gitcoin-txs.csv 2>/dev/null
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate         --fmt csv                           >two/gitcoin-txs.csv

chifra monitors --decache 0xd95a1969c41112cee9a2c931e849bcef36a16f4c
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv --logs                    >one/gitcoin-logs.csv 2>/dev/null
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate         --fmt csv --logs                    >two/gitcoin-logs.csv

chifra monitors --decache 0xd95a1969c41112cee9a2c931e849bcef36a16f4c
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv --receipts                >one/gitcoin-reciepts.csv 2>/dev/null
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate         --fmt csv --receipts                >two/gitcoin-reciepts.csv

chifra monitors --decache 0xd95a1969c41112cee9a2c931e849bcef36a16f4c
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv --traces --cache_traces   >one/gitcoin-traces.csv 2>/dev/null
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate         --fmt csv --traces                  >two/gitcoin-traces.csv

chifra monitors --decache 0xd95a1969c41112cee9a2c931e849bcef36a16f4c
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv --accounting --statements >one/gitcoin-statements.csv 2>/dev/null
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate         --fmt csv --accounting --statements >two/gitcoin-statements.csv

chifra monitors --decache 0xd95a1969c41112cee9a2c931e849bcef36a16f4c
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate --cache --fmt csv --neighbors               >one/gitcoin-neighbors.csv 2>/dev/null
time chifra export 0xd95a1969c41112cee9a2c931e849bcef36a16f4c --articulate         --fmt csv --neighbors               >two/gitcoin-neighbors.csv

diff -r one two >diff.fil 2>&2
echo -n nDiff:
wc diff.fil
