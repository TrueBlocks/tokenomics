#----------------------------------------
# This exploration compares Vitalik's
# Python-generate projection againt
# available data
#----------------------------------------
require(tidyverse)
require(scales)
require(dplyr)
require(magrittr)

difficulty = read_csv('./store/difficulty/difficulty.csv') %>%
  mutate(parent.difficulty = lag(difficulty)) %>%
  mutate(parent.ts = lag(timestamp)) %>%
  mutate(diff.delta = parent.difficulty - difficulty) %>%
  mutate(ts.delta = parent.ts - timestamp)
head(difficulty)

# Vatlik's python calc of expected difficulty
vitalik_pre_byzantium = read_csv('./store/difficulty/vitalik_pre_byzantium.csv')
vitalik_pre_byzantium %>%
  ggplot(aes(x=blocknumber)) +
  geom_line(aes(y=block_time))

compare <- left_join(difficulty, vitalik_pre_byzantium, by = 'blocknumber')
compare %>%
  filter( blocknumber <= max(vitalik_pre_byzantium$blocknumber) ) %>%
  filter( blocknumber >= min(vitalik_pre_byzantium$blocknumber) ) %>%
  filter( mod(blocknumber, 10000) == 0) %>%
  ggplot(aes(x=blocknumber)) +
  geom_line(aes(y=block_time)) +
  geom_line(aes(y=ts.delta))

