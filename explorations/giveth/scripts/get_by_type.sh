#!/usr/bin/env bash

mkdir -p types

echo "---- Getting $1 for all rounds -------"
giveth data $1 --fmt csv >types/$1.csv
