#!/usr/bin/env bash

export LOG_TIMING_OFF=true
export NO_COLOR=true

echo "---------------------- master ----------------------"
time chifra-master receipts --file txs.dat --fmt txt >results 2>&1
time chifra-master receipts --file txs.dat --fmt csv >results 2>&1
time chifra-master receipts --file txs.dat --fmt json >results 2>&1

echo "---------------------- develop ----------------------"
time chifra-develop receipts --file txs.dat --fmt txt >results 2>&1
time chifra-develop receipts --file txs.dat --fmt csv >results 2>&1
time chifra-develop receipts --file txs.dat --fmt json >results 2>&1

echo "---------------------- perf ----------------------"
time chifra-perf receipts --file txs.dat --fmt txt >results 2>&1
time chifra-perf receipts --file txs.dat --fmt csv >results 2>&1
time chifra-perf receipts --file txs.dat --fmt json >results 2>&1
