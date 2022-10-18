#!/usr/bin/env bash

giveth data --fmt csv $1 --round $2 >data/rounds/Round$2/$1.csv
