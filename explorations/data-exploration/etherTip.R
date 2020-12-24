## This is an exploratory sandbox used for looking at etherTip data

require(readr)
require(dplyr)
require(ggplot2)

etherTip <- read_lines('../../monitors/output/etherTip.json') %>% jsonlite::fromJSON(flatten = T) %>% as_tibble()

etherTip %>%
  group_by(blockNumber) %>%
  summarize(n = n()) %>%
  ggplot(aes(x = blockNumber, y = n)) +
  geom_line()

etherTip %>%
  group_by(to) %>%
  summarize(n = n()) %>%
  arrange(desc(n))

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

etherTip %>%
  mutate(isGain = ifelse(to == '0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359', T, F)) %>%
  mutate(value = value / 1000000000000000000) %>%
  View()

etherTip$receipt.logs %>% bind_rows() %>% View()
