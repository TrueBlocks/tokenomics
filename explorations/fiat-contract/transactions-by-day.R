library(readr)
require(tidyverse)
require(scales)
require(dplyr)
require(magrittr)

transactions <- read_csv("transactions.csv")
head(transactions)

block.dates <- data.frame(transactions$blocknumber, as.Date(transactions$date))
head(block.dates)

block.dates <-
  block.dates %>%
  group_by(as.Date.transactions.date) %>%
  count(date)
head(block.dates)

block.dates <- block.dates %>%
  filter(n != 222) %>%
  filter(n != 286)
  
block.dates

block.dates %>%
  ggplot(aes(x=date, y = n)) +
  geom_line()


block.dates <- block.date %>% summarize()
block.dates
plot(block.dates)
