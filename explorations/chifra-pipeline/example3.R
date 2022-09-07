# This file is in the public domain
require("tidyverse")
require("jsonlite")

address <- "0xf3db5fa2c66b7af3eb0c0b782510816cbe4813b8"
name <- "Everex"
source("/Users/jrush/Development/tokenomics/explorations/common/load_address.R")
everex_df <- ret
everex_df %>% ggplot(aes(x = blockNumber)) +
    geom_histogram(bins = 500)

address <- "0x9a642d6b3368ddc662ca244badf32cda716005bc"
name <- "Qtum"
source("/Users/jrush/Development/tokenomics/explorations/common/load_address.R")
qtum_df <- ret
qtum_df %>% ggplot(aes(x = blockNumber)) +
    geom_histogram(bins = 500)

address <- "0x9a0242b7a33dacbe40edb927834f96eb39f8fbcb"
name <- "Bax"
source("/Users/jrush/Development/tokenomics/explorations/common/load_address.R")
bax_df <- ret
bax_df %>% ggplot(aes(x = blockNumber)) +
    geom_histogram(bins = 500)

address <- "0x6090A6e47849629b7245Dfa1Ca21D94cd15878Ef"
name <- "ENS"
source("/Users/jrush/Development/tokenomics/explorations/common/load_address.R")
ens_df <- ret
ens_df %>% ggplot(aes(x = blockNumber)) +
    geom_histogram(bins = 500)

all_data <- bind_rows(everex_df, qtum_df, bax_df, ens_df)
all_data %>% ggplot(aes(x = blockNumber, fill = address)) +
    geom_histogram(bins = 500)
