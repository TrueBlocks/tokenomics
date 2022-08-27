#!/usr/bin/env bash

echo
echo "------------------------------------------------------------------------------------------------------------"
echo "Running fix.sh"
echo "------------------------------------------------------------------------------------------------------------"

if [ -z "$1" ]
then
    echo "Usage ./fix.sh <address>"
    exit
fi

echo "Fixing $1"

./scripts/clean.sh $1
./scripts/get_from_covalent $1
./scripts/get_from_trueblocks $1
./download.1.sh $1
