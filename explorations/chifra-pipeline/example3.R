# This file is in the public domain
require('tidyverse')
require('jsonlite')

everex <- "0xf3db5fa2c66b7af3eb0c0b782510816cbe4813b8"
test.data1 <- paste0("http://localhost:8080/list?address=", everex)
test.data1 <- test.data1 %>% fromJSON()
test.data1 <- test.data1 %>% as_tibble()
test.data1 <- test.data1 %>% mutate(address = "everex")
test.data1 %>% ggplot(aes(x=bn)) + geom_histogram(bins=500)
#test.data1 %>% View()

qtum <- "0x9a642d6b3368ddc662ca244badf32cda716005bc"
test.data2 <- paste0("http://localhost:8080/list?address=", qtum)
test.data2 <- test.data2 %>% fromJSON()
test.data2 <- test.data2 %>% as_tibble()
test.data2 <- test.data2 %>% mutate(address = "qtum")
test.data2 %>% ggplot(aes(x=bn)) + geom_histogram(bins=500)
#test.data2 %>% View()

bax = "0x9a0242b7a33dacbe40edb927834f96eb39f8fbcb"
test.data3 <- paste0("http://localhost:8080/list?address=", bax)
test.data3 <- test.data3 %>% fromJSON()
test.data3 <- test.data3 %>% as_tibble()
test.data3 <- test.data3 %>% mutate(address = "bax")
test.data3 %>% ggplot(aes(x=bn)) + geom_histogram(bins=500)
#test.data3 %>% View()

ens = "0x6090A6e47849629b7245Dfa1Ca21D94cd15878Ef"
test.data4 <- paste0("http://localhost:8080/list?address=", ens)
test.data4 <- test.data4 %>% fromJSON()
test.data4 <- test.data4 %>% as_tibble()
test.data4 <- test.data4 %>% mutate(address = "ens")
test.data4 %>% ggplot(aes(x=bn)) + geom_histogram(bins=500)
#test.data4 %>% View()

test.data5 <- bind_rows(test.data1, test.data2)
#test.data5 %>% View()
test.data6 <- bind_rows(test.data3, test.data4)
#test.data6 %>% View()
test.data7 <- bind_rows(test.data5, test.data6)
#test.data7 %>% View()

test.data7 %>% ggplot(aes(x=bn, fill=address)) + geom_histogram(bins=500)
