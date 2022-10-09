#!/usr/bin/env bash

mkdir -p data/all

echo "---- Getting projects -------"
giveth projects --fmt json | jq >data/all/projects.json
