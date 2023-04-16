#!/usr/bin/env bash

OSS_ROUND_17=0xd95a1969c41112cee9a2c931e849bcef36a16f4c

time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --appearances             >output/appearances.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv                           >output/txs.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --logs                    >output/logs.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --receipts                >output/reciepts.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --traces                  >output/traces.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --accounting --statements >output/statements.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --neighbors               >output/neighbors.csv

./compress.sh
