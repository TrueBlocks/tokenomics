#!/usr/bin/env bash

echo "---- Getting $1 for round $2 -------"
giveth data --fmt csv $1 --round $2 >rounds/Round$2/$1.csv
