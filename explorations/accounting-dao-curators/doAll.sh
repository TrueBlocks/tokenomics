#!/usr/bin/env bash

rm -fR raw summary
mkdir -p raw/txs raw/recons raw/logs summary
echo >summary/all_recons.csv
echo >summary/all_logs.csv

# Add one line per address here
./doOne.sh 0x0029218e1dab069656bfb8a75947825e7989b987
./doOne.sh 0x0037a6b811ffeb6e072da21179d11b1406371c63
./doOne.sh 0x127ac03acfad15f7a49dd037e52d5507260e1425
./doOne.sh 0x1db3439a222c519ab44bb1144fc28167b4fa6ee6
./doOne.sh 0x820c6da74978799d574f61b01f8b5eebc051f95e
./doOne.sh 0x82aeb1d8939f514318449fa8ec704a94dc16e01d
./doOne.sh 0xae90d602778ed98478888fa2756339dd013e34c1
./doOne.sh 0xb274363d5971b60b6aca27d6f030355e9aa2cf23
./doOne.sh 0xb2c1b92f4bed7a173547cc601fb73a1254d10d26
./doOne.sh 0xc157f767030b4cdd1f4100e5eb2b469b688d293e
./doOne.sh 0xc947faed052820f1ad6f4dda435e684a2cd06bb4
./doOne.sh 0xd1220a0cf47c7b9be7a2e6ba89f429762e7b9adb
./doOne.sh 0xe578fb92640393b95b53197914bd560b7bc2aac8
./doOne.sh 0xf9ffba430e290c7fa4be61e3a2f905f6c99dd616

sort summary/all_recons.csv >x
cat header.csv >summary/all_recons.csv
cat x | grep -v "^$" >>summary/all_recons.csv

sort summary/all_logs.csv >x
cat logs_header.csv >summary/all_logs.csv
cat x | grep -v "^$" >>summary/all_logs.csv

rm -f x
