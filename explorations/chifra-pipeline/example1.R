# This file is in the public domain
require('tidyverse')
require('jsonlite')

## select an Ethereum address
address <- "0xab5801a7d398351b8be11c439e05c5b3259aec9b%200x1db3439a222c519ab44bb1144fc28167b4fa6ee6"

## Create a url to one of the TrueBlocks API endpoints
url <- paste0("http://localhost:8080/export?addrs=", address, "&statements&write_txs&write_traces")

## Get the data from TrueBlock
jsonData <- url %>% fromJSON(simplifyVector = TRUE)
origDf = jsonData["data"]$data %>% as_data_frame()

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

