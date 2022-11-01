#!/usr/bin/env bash

mkdir -p exports/mainnet/summaries/
mkdir -p exports/mainnet/holders/all_time/counts
mkdir -p exports/mainnet/holders/at_block_$3/counts

echo Finding holders of $2 on $1 chain...

cat exports/mainnet/summaries/$2.csv | grep -v recipient | cut -d, -f7,8 | tr ',' '\n' | sort | uniq | grep -v $2 >exports/mainnet/holders/all_time/$2.csv
echo "0x0000000000000000000000000000000000000000" >>exports/mainnet/holders/all_time/$2.csv
cat exports/mainnet/summaries/$2.csv | grep -v recipient | cut -d, -f7,8 | tr ',' '\n' | sort | uniq -c | sort -n -r >exports/mainnet/holders/all_time/counts/$2.csv

chifra --chain $1 tokens --fmt csv --no_header --no_zero $2 --file exports/mainnet/holders/all_time/$2.csv $3 | tee -a temp_file

echo "blockNumber,holder,address,symbol,balance" >exports/mainnet/holders/at_block_$3/$2.csv
cat temp_file | sed 's/\"//g' | tr ',' '\t' | cut -f1,2,3,5,7 | sort -r -n -k 5 -k 2 | tr '\t' ',' | sed 's/,0x0,/,0x0000000000000000000000000000000000000000,/'>>exports/mainnet/holders/at_block_$3/$1.csv
rm -f temp_file
