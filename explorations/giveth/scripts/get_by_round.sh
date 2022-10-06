#!/usr/bin/env bash

mkdir -p rounds/Round$1

./scripts/get_details.sh purple-list     $1
./scripts/get_details.sh not-eligible    $1
./scripts/get_details.sh eligible        $1
./scripts/get_details.sh calc-givback    $1
./scripts/get_details.sh purple-verified $1
