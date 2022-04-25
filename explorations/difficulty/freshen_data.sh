#!/usr/bin/env bash

cat store/difficulty-000000000-000999999.txt  >store/difficulty.csv ; echo "1000000"
cat store/difficulty-001000000-001999999.txt >>store/difficulty.csv ; echo "2000000"
cat store/difficulty-002000000-002999999.txt >>store/difficulty.csv ; echo "3000000"
cat store/difficulty-003000000-003999999.txt >>store/difficulty.csv ; echo "4000000"
cat store/difficulty-004000000-004999999.txt >>store/difficulty.csv ; echo "5000000"
cat store/difficulty-005000000-005999999.txt >>store/difficulty.csv ; echo "6000000"
cat store/difficulty-006000000-006999999.txt >>store/difficulty.csv ; echo "7000000"
cat store/difficulty-007000000-007999999.txt >>store/difficulty.csv ; echo "8000000"
cat store/difficulty-008000000-008999999.txt >>store/difficulty.csv ; echo "9000000"
cat store/difficulty-009000000-009999999.txt >>store/difficulty.csv ; echo "10000000"
cat store/difficulty-010000000-010999999.txt >>store/difficulty.csv ; echo "11000000"
cat store/difficulty-011000000-011999999.txt >>store/difficulty.csv ; echo "12000000"
cat store/difficulty-012000000-012999999.txt >>store/difficulty.csv ; echo "13000000"
cat store/difficulty-013000000-013999999.txt >>store/difficulty.csv ; echo "14000000"
cat store/difficulty-014000000-014999999.txt >>store/difficulty.csv
#; echo "projected"
# cat store/difficulty-projected.csv         >>store/difficulty.csv ; 
wc store/difficulty.csv

echo "blocknumber,timestamp,difficulty" >x
sort -u -n store/difficulty.csv >>x
rm -f store/difficulty.csv
mv x store/difficulty.csv

echo -n " "
tail -1 store/difficulty-014000000-014999999.txt
