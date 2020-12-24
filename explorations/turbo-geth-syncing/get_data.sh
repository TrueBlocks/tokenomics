cat sorted.csv | cut -d, -f1,6,10,20-22 | sed 's/::/_/g' >totals.csv
pico sorted.csv ; cat data/*.txt | sort -u >>sorted.csv
cat data/fields.txt >sorted.csv

scp -pr "wildmolasses:/home/jrush/Development/trueblocks-core/build/data/*txt.gz" .

