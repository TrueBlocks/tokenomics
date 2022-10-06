#!/usr/bin/env bash

./scripts/get_by_round.sh 1
./scripts/get_by_round.sh 2
./scripts/get_by_round.sh 3
./scripts/get_by_round.sh 4
./scripts/get_by_round.sh 5
./scripts/get_by_round.sh 6
./scripts/get_by_round.sh 7
./scripts/get_by_round.sh 8
./scripts/get_by_round.sh 9
./scripts/get_by_round.sh 10
./scripts/get_by_round.sh 11
./scripts/get_by_round.sh 12
./scripts/get_by_round.sh 13
./scripts/get_by_round.sh 14
./scripts/get_by_round.sh 15
./scripts/get_by_round.sh 16
./scripts/get_by_round.sh 17
./scripts/get_by_round.sh 18
./scripts/get_by_round.sh 19

./scripts/get_by_type.sh purple-list
./scripts/get_by_type.sh not-eligible
./scripts/get_by_type.sh eligible
./scripts/get_by_type.sh calc-givback
./scripts/get_by_type.sh purple-verified

echo "---- Getting all data -------"
mkdir -p all
giveth data purple-verified --fmt csv  >all/all.csv
giveth data not-eligible    --fmt csv | grep -v "\"type\",\"round\",\"amount\"" >>all/all.csv
giveth data eligible        --fmt csv | grep -v "\"type\",\"round\",\"amount\"" >>all/all.csv
