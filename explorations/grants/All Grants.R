libary(tidyverse)

newAddrs <- read.delim("/Users/jrush/Desktop/All Grants.txt", colClasses="character") %>%
  mutate(address = tolower(address))
head(newAddrs)

oldAddrs <- read.delim("/Users/jrush/Development/trueblocks-core/src/other/install/names/names.tab", colClasses="character")
nrow(oldAddrs)
oldAddrs$tags
oldAddrs <- oldAddrs %>% filter(tags == "31-Gitcoin Grants:Grant")
nrow(oldAddrs)
head(oldAddrs)
