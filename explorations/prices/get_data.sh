#!/usr/bin/env bash

echo "Getting data..."
date
ethQuote --freshen --period 5 | tr '\t' ',' >store/prices.csv
tail store/prices.csv
