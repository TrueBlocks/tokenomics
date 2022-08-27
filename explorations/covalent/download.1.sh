#!/usr/bin/env bash

#./scripts/get_from_trueblocks $1
#./scripts/get_from_covalent $1
# sleep 1

./scripts/process_trueblocks $1
./scripts/process_covalent $1

./scripts/post_process $1
sleep 1
