require("tidyverse")
require("jsonlite")
require("chifra")

n_bins = 2000

tb_df <- get_tx_list("trueblocks.eth", "TrueBlocks")
#tb_df %>% ggplot(aes(x = blockNumber)) +
#    geom_histogram(bins = n_bins)

rotki_df <- get_tx_list("rotki.eth", "Rotki")
#rotki_df %>% ggplot(aes(x = blockNumber)) +
#  geom_histogram(bins = n_bins)

umbra_df <- get_tx_list("0x57ea12a3a8e441f5fe7b1f3af1121097b7d3b6a8", "Bumbra")
#umbra_df %>% ggplot(aes(x = blockNumber)) +
#  geom_histogram(bins = n_bins)

all_data <- bind_rows(rotki_df, umbra_df, tb_df)
# all_data <- all_data %>% filter(blockNumber > 14900000 & blockNumber < 15100000)
n_bins = 400
all_data %>% ggplot(aes(x = blockNumber, fill = address)) +
    geom_histogram(bins = n_bins)
