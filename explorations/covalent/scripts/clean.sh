#!/usr/bin/env bash

chifra monitors --delete --remove $1
#find store/ -name "*"$1"*" -exec ls -l {} ';'
find store/ -name "*"$1"*" -exec rm {} ';'
