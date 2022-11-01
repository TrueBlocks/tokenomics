#!/usr/bin/env bash

cd monitors

CHAIN="${1:-mainnet}"

../scripts/summarize.sh.1 $CHAIN 0xee3b01b2debd3df95bf24d4aacf8e70373113315 15854548
../scripts/summarize.sh.1 $CHAIN 0x60cd8dcc7cce0cca6a3743727ce909b6f715b2d8 15854548
