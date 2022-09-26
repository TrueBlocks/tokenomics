#!/usr/bin/env bash

CNT=${1:-2874}

pico fix.sh 
./fix.sh master  $CNT  ; pico ./master.sh
./fix.sh develop $CNT  ; pico ./develop.sh
./fix.sh perf    $CNT  ; pico ./perf.sh
wc *.sh | grep -v fix | grep -v total | grep -v test | grep -v api
wc txs.dat
