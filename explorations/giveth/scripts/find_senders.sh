#!/usr/bin/env bash

HASH=$1
CHAIN=$2

echo "Hash:  " $HASH
echo "Chain: " $CHAIN

chifra transactions --uniq --flow from $HASH --chain $CHAIN
chifra transactions --fmt json $HASH --chain $CHAIN
