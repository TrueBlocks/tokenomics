## This is an exploratory sandbox used for looking at etherTip data

require(readr)
require(dplyr)
require(ggplot2)

etherTip <- read_lines('store/etherTip/etherTip.json') %>%
  jsonlite::fromJSON(flatten = T) %>%
  as_tibble()
etherTip <- etherTip$data %>% filter(to == "0x8428ce12a1b6aaecfcf2ac5b22d21f3831949da3")
head(etherTip)

grouped.by.count <-etherTip %>%
  group_by(blockNumber) %>%
  summarize(tx_count = n())

grouped.by.count %>%
  ggplot(aes(x = blockNumber, y = tx_count)) +
  geom_line()

grouped.by.to <- etherTip %>%
  group_by(to) %>%
  summarize(to_count = n()) %>%
  arrange(desc(to_count))
grouped.by.to

grouped.by.to %>%
  ggplot(aes(y = tt)) +
  geom_bar()

etherTip %>%
  filter(to == '0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359') %>%
  transform(value = value / 1000000000) %>%
  group_by(blockNumber) %>%
  summarize(value = sum(value)) %>%
  arrange(blockNumber) %>%
  mutate(cumsum = cumsum(value)) %>%
  ggplot(aes(x = blockNumber, y = cumsum)) +
  geom_line()

## balance of etherTip over time
etherTip %>%
  mutate(isGain = ifelse(to == '0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359', T, F)) %>%
  mutate(value = value / 1000000000) %>%
  mutate(value = ifelse(isGain, value, -value)) %>%
  group_by(blockNumber) %>%
  summarize(value = sum(value)) %>%
  arrange(blockNumber) %>%
  mutate(cumsum = cumsum(value)) %>%
  ggplot(aes(x = blockNumber, y = cumsum)) +
  geom_line()

#etherTip %>%
#  mutate(isGain = ifelse(to == '0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359', T, F)) %>%
#  mutate(value = value / 1000000000000000000) %>%
#  View()

#etherTip$receipt.logs %>% bind_rows() %>% View()
