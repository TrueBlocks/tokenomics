#!/usr/bin/env bash

echo -n $1 " "
chifra names -l --no_header -m $1
sleep 0.2
