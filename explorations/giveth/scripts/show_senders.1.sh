#!/usr/bin/env bash

ADDR=$1
TOKEN=$2
CHAIN=$3
FIRST=$4
LAST=$5
TOPIC="0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef"

echo "Addr:  " $ADDR
echo "Token: " $TOKEN
echo "Chain: " $CHAIN
echo "First: " $FIRST
echo "Last:  " $LAST

echo "exporting..."
chifra export $ADDR --chain $CHAIN --logs --emitter $TOKEN --first_block $FIRST --last_block $LAST --cache --articulate $TOPIC >x

echo "cutting..."
cat x | cut -f1-5,11 | tr ':' '\t' | tr '|' '\t' | tr '{' '\t' | cut -f1-5,8,12,14,16 | cut -f1 -d'}' | grep "\t"$ADDR$ | tee zz
cat zz | cut -f8 | sort -u
