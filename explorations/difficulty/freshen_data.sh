#!/usr/bin/env bash

cat store/difficulty/difficulty-000000000-000999999.txt | tr '\t' ','  >store/difficulty/difficulty.csv
cat store/difficulty/difficulty-001000000-001999999.txt | tr '\t' ',' >>store/difficulty/difficulty.csv
cat store/difficulty/difficulty-002000000-002999999.txt | tr '\t' ',' >>store/difficulty/difficulty.csv
cat store/difficulty/difficulty-003000000-003999999.txt | tr '\t' ',' >>store/difficulty/difficulty.csv
cat store/difficulty/difficulty-004000000-004999999.txt | tr '\t' ',' >>store/difficulty/difficulty.csv
cat store/difficulty/difficulty-005000000-005999999.txt | tr '\t' ',' >>store/difficulty/difficulty.csv
cat store/difficulty/difficulty-006000000-006999999.txt | tr '\t' ',' >>store/difficulty/difficulty.csv
cat store/difficulty/difficulty-007000000-007999999.txt | tr '\t' ',' >>store/difficulty/difficulty.csv
cat store/difficulty/difficulty-008000000-008999999.txt | tr '\t' ',' >>store/difficulty/difficulty.csv
cat store/difficulty/difficulty-009000000-009999999.txt | tr '\t' ',' >>store/difficulty/difficulty.csv
cat store/difficulty/difficulty-010000000-010999999.txt | tr '\t' ',' >>store/difficulty/difficulty.csv
cat store/difficulty/difficulty-011000000-011999999.txt | tr '\t' ',' >>store/difficulty/difficulty.csv

wc store/difficulty/difficulty.csv

echo "blocknumber,timestamp,difficulty" >x
sort -n store/difficulty/difficulty.csv >>x
rm -f store/difficulty/difficulty.csv
mv x store/difficulty/difficulty.csv
