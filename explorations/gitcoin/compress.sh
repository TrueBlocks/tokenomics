#!/usr/bin/env bash

cd output
gzip --keep --verbose --force *.csv
cd ..
