#!/usr/bin/env bash

mkdir -p data/givers

echo "---- Getting givers -------"
cat data/all/all.csv                  | cut -d, -f7 |cut -f2 -d'"' | grep -v giverAddress >data/givers/all.csv
giveth data purple-verified --fmt csv | cut -d, -f7 |cut -f2 -d'"' | grep -v giverAddress >data/givers/purple-verified.csv
giveth data not-eligible    --fmt csv | cut -d, -f7 |cut -f2 -d'"' | grep -v giverAddress >data/givers/not-eligible.csv
giveth data eligible        --fmt csv | cut -d, -f7 |cut -f2 -d'"' | grep -v giverAddress >data/givers/eligible.csv
