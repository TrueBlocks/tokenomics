#!/usr/bin/env bash

OSS_ROUND_17=0xd95a1969c41112cee9a2c931e849bcef36a16f4c

time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --appearances             >data/appearances.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv                           >data/txs.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --logs                    >data/logs.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --receipts                >data/reciepts.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --traces                  >data/traces.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --accounting --statements >data/statements.csv
time chifra export $OSS_ROUND_17 --articulate --cache --fmt csv --neighbors               >data/neighbors.csv
