# This file is in the public domain
require('tidyverse')
require('jsonlite')

vitalik1 <- "0xab5801a7d398351b8be11c439e05c5b3259aec9b"
vatalik2 <- "0x1db3439a222c519ab44bb1144fc28167b4fa6ee6"
trueblocks <- "0xf503017d7baf7fbc0fff7492b751025c6a78179b"

getTransactionList <- function(addr) {
  binSize = 25000
  cmd = "list"
  addr_part <- paste0("?addrs=", addr)
  options_part <- "" #paste0("&statements", "&write_txs", "&write_traces")
  url <- paste0("http://localhost:8080/", cmd, addr_part, options_part)
  jsonData <- url %>% fromJSON(simplifyVector = TRUE)
  df = jsonData["data"]$data %>% as_data_frame() %>%
    mutate(blockBin = floor(blockNumber / binSize) * binSize)
}

origDf = getTransactionList(vitalik2)
#View(origDf)

origDf %>% ggplot() +
  geom_bar(aes(x=blockBin))

## Let's look at the data a bit
head(origDf)
tail(origDf)

origDf %>%
  ggplot(aes(x=blockNumber, y = begBal)) +
  geom_point() +
  labs(yaxis="")

#df <- df %>% filter(ether > 1)
df <- origDf %>% mutate(tx_type = ifelse(from == address, "from", ifelse(to == address, "to", "other")))
  
## Make a rudimentary chart showing value transferred for this address.
df %>%
  ggplot(aes(x=ether, fill = tx_type)) +
  geom_histogram() +
  labs(caption = paste("This chart shows that address ", address, " was on the receiving end of a number of tx,",
    " but did not send any. You can also see the trace volume in blue, although it's not the most helpful ",
    " representation", sep = "\n"))

df <- df %>% filter(tx_type != "other")
df %>%
  ggplot(aes(x=blockNumber, y = ether, color = tx_type)) +
  geom_point()

