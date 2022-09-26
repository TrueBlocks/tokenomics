#!/usr/bin/env bash

export LOG_TIMING_OFF=true
export NO_COLOR=true

echo "---------------------- master ----------------------"
time ./master.sh --fmt txt >results 2>&1
time ./master.sh --fmt csv >results 2>&1
time ./master.sh --fmt json >results 2>&1

echo "---------------------- develop ----------------------"
time ./develop.sh --fmt txt >results 2>&1
time ./develop.sh --fmt csv >results 2>&1
time ./develop.sh --fmt json >results 2>&1

echo "---------------------- perf ----------------------"
time ./perf.sh --fmt txt >results 2>&1
time ./perf.sh --fmt csv >results 2>&1
time ./perf.sh --fmt json >results 2>&1
