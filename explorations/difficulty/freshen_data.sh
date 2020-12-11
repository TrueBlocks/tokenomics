#!/usr/bin/env bash

cat data/difficulty-000000000-000999999.txt | tr '\t' ','  >data/difficulty.csv
cat data/difficulty-001000000-001999999.txt | tr '\t' ',' >>data/difficulty.csv
cat data/difficulty-002000000-002999999.txt | tr '\t' ',' >>data/difficulty.csv
cat data/difficulty-003000000-003999999.txt | tr '\t' ',' >>data/difficulty.csv
cat data/difficulty-004000000-004999999.txt | tr '\t' ',' >>data/difficulty.csv
cat data/difficulty-005000000-005999999.txt | tr '\t' ',' >>data/difficulty.csv
cat data/difficulty-006000000-006999999.txt | tr '\t' ',' >>data/difficulty.csv
cat data/difficulty-007000000-007999999.txt | tr '\t' ',' >>data/difficulty.csv
cat data/difficulty-008000000-008999999.txt | tr '\t' ',' >>data/difficulty.csv
cat data/difficulty-009000000-009999999.txt | tr '\t' ',' >>data/difficulty.csv
cat data/difficulty-010000000-010999999.txt | tr '\t' ',' >>data/difficulty.csv
cat data/difficulty-011000000-011999999.txt | tr '\t' ',' >>data/difficulty.csv

wc data/difficulty.csv

echo "blocknumber,timestamp,difficulty" >x
sort -n data/difficulty.csv >>x
rm -f data/difficulty.csv
mv x data/difficulty.csv
