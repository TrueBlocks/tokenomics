#!/usr/bin/env bash

chifra state --parts balance $1 --no_header --ether 7800000-10200000:50000 | tr '\t' ','
