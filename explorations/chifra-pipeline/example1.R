require("tidyverse")
require("jsonlite")
require("chifra")

#vitalik1 <- get_statements("0xab5801a7d398351b8be11c439e05c5b3259aec9b", "Vitalik1")
#vatalik2 <- get_statements("0x1db3439a222c519ab44bb1144fc28167b4fa6ee6", "Vitalik2")
trueblocks <- get_statements("0xf503017d7baf7fbc0fff7492b751025c6a78179b&maxRecords=3000&ether", "TrueBlocks")

bin_size <- 25000

#vitalik1 <- vitalik1 %>% mutate(blockBin = floor(blockNumber / bin_size) * bin_size)
#vatalik2 <- vatalik2 %>% mutate(blockBin = floor(blockNumber / bin_size) * bin_size)
trueblocks <- trueblocks %>% mutate(blockBin = floor(blockNumber / bin_size) * bin_size)

df <- trueblocks

origDf <- df
head(origDf)

origDf %>% ggplot() +
  geom_bar(aes(x = blockBin))

## Let's look at the data a bit
head(origDf)
tail(origDf)

names(origDf)

#origDf %>%
#  ggplot(aes(x = blockNumber, y = begBal)) +
#  geom_point() +
#  labs(yaxis = "")

df <- origDf %>%
  mutate(tx_type = ifelse(assetAddr == address, "from", ifelse(assetAddr == address, "to", "other"))) %>%
  mutate(ether = amountNet)
  
names(df)
## Make a rudimentary chart showing value transferred for this address.
df %>%
  ggplot(aes(x = amountNet, fill = tx_type)) +
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
