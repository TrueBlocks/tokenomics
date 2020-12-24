#!/usr/bin/env bash
#
# Wrangles data exported by the FileMaker Pro demo

export PATH=$PATH:/usr/local/bin/

name=$1
address=$2
path=$3

echo "Processing: ----- $name --- $address --- at $path"

# The caller will tell the script where to run (this is an option in FileMaker Pro)
cd $path && \
 cat "header.line" | tr '\r' '\n' > data/output.csv && \
 cat "data/$name-$address.csv" | tr '\r' '\n' | sed 's/ PM//g' | sed 's/ AM//' | sed 's/invocation/call/' >> data/output.csv && \
 Rscript -e "rmarkdown::render('output.Rmd', \
      params = list( \
        filepath = 'data/output.csv', \
        address = '$address', \
        name = '$name' ))" && \
 open output.html
