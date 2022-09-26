#!/usr/bin/env bash

export LOG_TIMING_OFF=true
export NO_COLOR=true

echo "---------------------- master ----------------------"
time ./test-api.sh 8080 txt >results 2>&1
time ./test-api.sh 8080 csv >results 2>&1
time ./test-api.sh 8080 json >results 2>&1

echo "---------------------- develop ----------------------"
time ./test-api.sh 8081 txt >results 2>&1
time ./test-api.sh 8081 csv >results 2>&1
time ./test-api.sh 8081 json >results 2>&1

echo "---------------------- perf ----------------------"
time ./test-api.sh 8082 txt >results 2>&1
time ./test-api.sh 8082 csv >results 2>&1
time ./test-api.sh 8082 json >results 2>&1
