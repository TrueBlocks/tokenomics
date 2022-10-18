#!/usr/bin/env bash

export SHOW_ADDRS=true
export MAX_ROWS=10010010

giveth sof --round 18 --levels 5 2>/dev/null | tee results/round.18
giveth sof --round 17 --levels 5 2>/dev/null | tee results/round.17
giveth sof --round 16 --levels 5 2>/dev/null | tee results/round.16
giveth sof --round 15 --levels 5 2>/dev/null | tee results/round.15
giveth sof --round 14 --levels 5 2>/dev/null | tee results/round.14
giveth sof --round 13 --levels 5 2>/dev/null | tee results/round.13
giveth sof --round 12 --levels 5 2>/dev/null | tee results/round.12
giveth sof --round 11 --levels 5 2>/dev/null | tee results/round.11
giveth sof --round 10 --levels 5 2>/dev/null | tee results/round.10
giveth sof --round  9 --levels 5 2>/dev/null | tee results/round.09
giveth sof --round  8 --levels 5 2>/dev/null | tee results/round.08
giveth sof --round  7 --levels 5 2>/dev/null | tee results/round.07
giveth sof --round  6 --levels 5 2>/dev/null | tee results/round.06
giveth sof --round  5 --levels 5 2>/dev/null | tee results/round.05
giveth sof --round  4 --levels 5 2>/dev/null | tee results/round.04
giveth sof --round  3 --levels 5 2>/dev/null | tee results/round.03
giveth sof --round  2 --levels 5 2>/dev/null | tee results/round.02
giveth sof --round  1 --levels 5 2>/dev/null | tee results/round.01
