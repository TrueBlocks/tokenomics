#!/usr/bin/env bash

mkdir -p data/types

echo "---- Getting $1 for all rounds -------"
giveth data $1 --fmt csv >data/types/$1.csv
