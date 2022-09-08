require("tidyverse")
require("jsonlite")
require("chifra")

?jsonlite

bin_size <- 25000

# vitalik1 <- get_statements("0xab5801a7d398351b8be11c439e05c5b3259aec9b", "Vitalik1")
# vitalik1 <- vitalik1 %>% mutate(blockBin = floor(blockNumber / bin_size) * bin_size)

# vatalik2 <- get_statements("0x1db3439a222c519ab44bb1144fc28167b4fa6ee6", "Vitalik2")
# vatalik2 <- vatalik2 %>% mutate(blockBin = floor(blockNumber / bin_size) * bin_size)

trueblocks <- get_txs("0xf503017d7baf7fbc0fff7492b751025c6a78179b&maxRecords=3000&ether", "TrueBlocks")
trueblocks <- trueblocks %>% mutate(blockBin = floor(blockNumber / bin_size) * bin_size)

df <- trueblocks
df <- df %>%
  mutate(tx_type = ifelse(assetAddr == address, "from", ifelse(assetAddr == address, "to", "other"))) %>%
  mutate(ether = amountNet)
head(df)
names(df)

df %>% ggplot() +
  geom_bar(aes(x = blockBin))

df %>%
  ggplot(aes(x = blockNumber, fill = tx_type)) +
  geom_histogram() +
  labs(caption = paste("This chart shows that address  was on the receiving end of a number of tx,",
    " but did not send any. You can also see the trace volume in blue, although it's not the most helpful ",
    " representation",
    sep = "\n"
  ))

df <- df %>% filter(tx_type != "other")
df %>%
  ggplot(aes(x = blockNumber, y = ether, color = tx_type)) +
  geom_point()
