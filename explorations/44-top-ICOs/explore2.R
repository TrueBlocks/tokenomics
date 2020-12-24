# This R script shows movements in ICO token ownership over time.
# It is also a good example of how to work with JSON data from QuickBlocks.

# Of Interest to Alvaro (UAM):
#    ownership of tokens (corporate structure)
#    interesting events by big owners
#    (cap [ownership] table at every timestamp with price as well)
#    events DURING ico

# Start of Script

# Package requirements: run these commands if packages not yet installed
#     package.install(tidyverse)
#     package.install(jsonlite)

require(tidyverse)
require(jsonlite)

initialSupply <- list(
  'newbium' = data.frame(
    address = '0xc9d7fec9889690bbff0a0df758d13e5a55dd7822', 
    address.type = 'transfer.to',
    timestamp = 1499459125,
    transfer.amount = 49000000
  )
)

# File Input
#   Right now, we're only working with newbium data.
#   In $project_directory/jsondata, Put the newbium json file generated from QuickBlocks.

jsonfiles <- list.files(path = "./jsondata")

tokenName = 'mith'
tokenAddr = '0x3893b9422cd5d70a81edeffe3d5a1c6a978310bb'

# We'll ultimately add more config such as latestBlock (6218382) to be more descriptive in the resulting filename.

# A lot of data operations going on below to transform the json into the structures we require.

data <- read_json(path = paste0('jsondata/',jsonfiles[3]), simplifyVector=T, simplifyDataFrame=T) %>%
  jsonlite::flatten() %>%
  as_data_frame() %>%
  mutate(fn.name = map_chr(articulatedTx, 'name', .default = NA)) %>%
  mutate(date = as.POSIXct(timestamp, origin = '1970-01-01') %>% as.Date()) 

  # To see the object generated, execute the following line:
  data

in.out <- data %>% filter(fn.name == 'transfer', !isError) %>%
  mutate(transfer.values = map(articulatedTx, list('inputs',1, 'value'), .default = NA)) %>%
  mutate(transfer.to = map_chr(transfer.values, 1)) %>%
  mutate(transfer.amount = map_chr(transfer.values, 2) %>% as.double()) %>%
  select(timestamp, from, transfer.to, transfer.amount) %>%
  ungroup()

  # To see the object generated, execute the following line:
  in.out

in.out.cum <- in.out %>% 
  gather(key = 'address.type', value = 'address', 2:3) %>%
  mutate(transfer.amount = ifelse(address.type == 'from', -transfer.amount, transfer.amount)) %>%
  group_by(address, timestamp) %>%
  summarize(transfer.amount = sum(transfer.amount)) %>%
  mutate(cumBalance = cumsum(transfer.amount)) %>%
  ungroup()

  # To see the object generated, execute the following line:
  in.out.cum

# Take the cross product of timestamps and addresses.
# We do this because we want each address to have a record for each timestamp, even when nothing occurs.
timestamps <- in.out.cum %>% distinct(timestamp)
addresses <- in.out.cum %>% distinct(address)
address.timestamp <- crossing(addresses, timestamps) %>% arrange(address, timestamp)

  # To see the object generated, execute the following line:
  address.timestamp


# Contract was instantiated with an Initial Supply that went entirely to the msg.sender.
# We add this manually.
addInitialSupplyBalance = function(data, tokenName) {
  data %>%
    rbind(initialSupply[[tokenName]]) %>%
    return()
}

# Here's the final data structure with debits and credits per address per each timestamp.
# From this, you can calculate the ownership table at any time.
in.out.cum.with.zeroes <- in.out %>%
  gather(key = 'address.type', value = 'address', 2:3) %>%
  addInitialSupplyBalance(tokenName) %>%
  mutate(transfer.amount = ifelse(address.type == 'from', -transfer.amount, transfer.amount)) %>%
  group_by(address, timestamp) %>%
  summarize(transfer.amount = sum(transfer.amount)) %>%
  full_join(address.timestamp) %>%
  arrange(address, timestamp) %>%
  mutate(transfer.amount = ifelse(is.na(transfer.amount),0,transfer.amount)) %>%
  group_by(address, timestamp) %>%
  summarize(transfer.amount = sum(transfer.amount)) %>%
  mutate(cumBalance = cumsum(transfer.amount)) %>%
  ungroup()

  # To see the object generated, execute the following line:
  in.out.cum.with.zeroes

# This is all you need for your table, so let's export it to csv.
in.out.cum.with.zeroes %>% write_csv(paste0(tokenName, '-ownership-table-per-timestamp-01a.csv')


# Meanwhile, let's do some visualization.

# First we extract the top 10 addresses with highest balance at any point in time.
top.10 <- in.out.cum.with.zeroes %>%
  group_by(address) %>%
  top_n(1, cumBalance) %>%
  distinct(address, .keep_all = T) %>%
  ungroup() %>%
  top_n(10, cumBalance) %>%
  select(address)

# This is a plot of their percent ownership relative to each other.
in.out.cum.with.zeroes %>%
  filter(address %in% top.10$address) %>%
  ggplot(aes(x = timestamp, y = cumBalance, fill=address)) +
  geom_area(position='fill')

# This is a plot of their ownership relative to everyone else.
in.out.cum.with.zeroes %>%
  mutate(is.top.10 = ifelse(address %in% top.10$address, TRUE, FALSE)) %>%
  group_by(is.top.10, timestamp) %>%
  summarize(cumBalance = sum(cumBalance)) %>%
  ggplot(aes(x = timestamp, y = cumBalance, group=is.top.10, fill=is.top.10)) +
  geom_area(position='fill')

# This is a combination of both plots above.
in.out.cum.with.zeroes %>%
  # filter(timestamp <= 1499459125 + 100000) %>%
  mutate(address = ifelse(address %in% top.10$address, address, 'other')) %>%
  group_by(address, timestamp) %>%
  arrange(address, timestamp) %>%
  summarize(cumBalance = sum(cumBalance)) %>%
  ggplot(aes(x = timestamp, y = cumBalance, fill=address)) +
  geom_area(position='fill')

# Thanks. Hope this helps! Improvements coming soon.