# This file is in the public domain
require("tidyverse")
require("jsonlite")
# require("/Users/jrush/Development/tokenomics/explorations/common/load_address.R")

#' A function
#'
#' @param address An Ethereum address
#' @param name A name to assign to that address
#'
#' @return The dataframe containing all the appearances <blockNumber, transactionIndex> for the given address
#' @importFrom dplyr mutate
#' @importFrom rlang enquo
#' @importFrom rlang quo_name
#' @importFrom rlang :=
#' @export
get_tx_list <- function(address, name) {
    df <- paste0("http://localhost:8080/list?addrs=", address) %>%
        fromJSON()
    df$data %>%
        as_tibble() %>%
        mutate(address = name)
}

everex_df <- get_tx_list("0xf3db5fa2c66b7af3eb0c0b782510816cbe4813b8", "Everex")
everex_df %>% ggplot(aes(x = blockNumber)) +
    geom_histogram(bins = 500)

qtum_df <- get_tx_list("0x9a642d6b3368ddc662ca244badf32cda716005bc", "Qtum")
qtum_df %>% ggplot(aes(x = blockNumber)) +
    geom_histogram(bins = 500)

bax_df <- get_tx_list("0x9a0242b7a33dacbe40edb927834f96eb39f8fbcb", "Bax")
bax_df %>% ggplot(aes(x = blockNumber)) +
    geom_histogram(bins = 500)

ens_df <- get_tx_list("0x6090A6e47849629b7245Dfa1Ca21D94cd15878Ef", "ENS")
ens_df %>% ggplot(aes(x = blockNumber)) +
    geom_histogram(bins = 500)

tb_df <- get_tx_list("trueblocks.eth", "TrueBlocks")
tb_df %>% ggplot(aes(x = blockNumber)) +
    geom_histogram(bins = 500)

all_data <- bind_rows(everex_df, qtum_df, bax_df, ens_df, tb_df)
all_data %>% ggplot(aes(x = blockNumber, fill = address)) +
    geom_histogram(bins = 500)
