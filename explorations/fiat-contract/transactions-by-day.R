library(readr)
require(tidyverse)
require(scales)
require(dplyr)
require(magrittr)

transactions <- read_csv("transactions.csv")

block.dates <- data.frame(transactions$blocknumber, as.Date(transactions$date))

block.dates %>% head() %>% View()

block.dates <-
  block.dates %>%
  mutate(date = as.Date(date)) %>%
  group_by(date) %>%
  count(date)

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
