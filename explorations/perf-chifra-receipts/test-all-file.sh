#!/usr/bin/env bash

export LOG_TIMING_OFF=true
export NO_COLOR=true

echo "---------------------- master ----------------------"
#time bin/chifra-master receipts --file txs.dat --fmt txt >results 2>&1
time bin/chifra-master receipts --file txs.dat --fmt csv >results 2>&1
#time bin/chifra-master receipts --file txs.dat --fmt json >results 2>&1

echo "---------------------- develop ----------------------"
#time bin/chifra-develop receipts --file txs.dat --fmt txt >results 2>&1
time bin/chifra-develop receipts --file txs.dat --fmt csv >results 2>&1
#time bin/chifra-develop receipts --file txs.dat --fmt json >results 2>&1

echo "---------------------- perf ----------------------"
#time bin/chifra-perf receipts --file txs.dat --fmt txt >results 2>&1
time bin/chifra-perf receipts --file txs.dat --fmt csv >results 2>&1
#time bin/chifra-perf receipts --file txs.dat --fmt json >results 2>&1

echo "---------------------- cpp ----------------------"
#time bin/chifra-cpp receipts --file txs.dat --fmt txt >results 2>&1
time bin/chifra-cpp receipts --file txs.dat --fmt csv >results 2>&1
#time bin/chifra-cpp receipts --file txs.dat --fmt json >results 2>&1
