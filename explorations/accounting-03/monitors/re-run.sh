#!/usr/bin/env bash

# build the code
cd ~/Development/trueblocks-core/build
make -j 12 
cd -

CHAIN="${1:-mainnet}"

# cleanup
# rm -fR exports/
# rm -fR /Users/jrush/Data/trueblocks/v0.40.0/cache/$CHAIN/recons/ee3b 2>/dev/null
# rm -fR /Users/jrush/Data/trueblocks/v0.40.0/cache/$CHAIN/recons/60cd 2>/dev/null
# cd ../
# #rm -f /Users/jrush/Data/trueblocks/v0.40.0/cache/$CHAIN/monitors/0xee3b*
# #rm -f /Users/jrush/Data/trueblocks/v0.40.0/cache/$CHAIN/monitors/0x60cd*
# cd -

# # freshen the monitored data
# export RUN_ONCE=true
# chifra monitors --watch --chain $CHAIN

# summarize
cd ..
scripts/summarize.sh $CHAIN
