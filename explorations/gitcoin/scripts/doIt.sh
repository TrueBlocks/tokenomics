#!/usr/bin/env bash

chifra export $2 --accounting --no_header --articulate | grep splitTransfer | sed 's/toSecond: 0x00de4b13153673bcae2616b67bf822500d325fc3, valueFirst://' | sed 's/splitTransfer ( toFirst://' | sed 's/valueSecond://' | sed 's/tokenAddress: //' | sed 's/ UTC//' | sed 's/ )//' | grep -v ",$2," | grep ",0," | sed 's/0x6b175474e89094c44da98b954eedeac495271d0f/DAI/' | sort -r >data/$1.csv
code data/$1.csv
