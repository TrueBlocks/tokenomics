# This file is in the public domain
require(tidyverse)
require(scales)
require(magrittr)

parity.archive.size <- read_tsv('data/directory-size.log', col_names = c("timestamp", "size", "dir")) %>%
  filter(str_detect(dir, "/archive")) %>%
  filter(timestamp != 1544481541)

parity.logs <- read_lines('data/archive-sync.log') %>%
  str_subset(pattern = 'Syncing') %>%
  substr(1, 37) %>%
  str_split("  ", n = 2, simplify = TRUE) %>%
  as_data_frame() %>%
  rename("date" = V1, "block" = V2) %>%
  mutate(block = str_split(block, "#", simplify=T)[,2] %>% as.integer()) %>%
  mutate(date = as.POSIXct(date))

blockscrape.logs <- read_tsv('data/block-scrape-data-2.log', col_names = c(
  "block-date",
  "run-date",
  "duration",
  "blockNum",
  "txs",
  "trcs",
  "depth",
  "addrs",
  "status",
  "blooms"
)) %>% bind_rows(read_tsv('data/block-scrape-data.log')) %>% arrange(`block-date`)

blockscrape.logs.addr.index <- read_tsv('data/block-scrape-data-acct-addr.log', col_names = c(
  "block-date",
  "run-date",
  "duration",
  "blockNum",
  "txs",
  "trcs",
  "depth",
  "addrs",
  "size",
  "blooms"
))

# acctscrape <- read_tsv('data/acct-scrape-0.log') %>% bind_rows(read_tsv('data/acct-scrape.log'))
# miniblock <- read_tsv('data/mini-block-data-0.log') %>% bind_rows(read_tsv('data/mini-block-data.log'))

blockscrape.logs.min.date <- min(blockscrape.logs$`run-date`)
blockscrape.logs.addr.index.min.date <- min(blockscrape.logs.addr.index$`run-date`)
parity.logs.min.date <- min(parity.logs$date)
