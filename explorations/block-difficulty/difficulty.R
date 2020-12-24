# This file is in the public domain
require(tidyverse)
require(scales)
require(dplyr)
require(magrittr)

homestead.block <- 1150000
byzantium.block <- 4370000
bin_size        <- 200
period_size     <- 100000
sample_size     <- 50000

difficulty <- read_csv('data/difficulty.csv') %>%
  filter(block.number > homestead.block) %>%
  mutate(block.bin = floor(block.number / bin_size) * bin_size) %>%
  mutate(fake.block = ifelse(block.number >= byzantium.block, block.number - 3000000, block.number) + 1) %>%
  mutate(period = floor(fake.block / period_size)) %>%
  mutate(bomb = 2 ^ period) %>%

  mutate(parent.difficulty = lag(difficulty)) %>%
  mutate(parent.ts = lag(timestamp)) %>%
  
  mutate(diff.delta = difficulty - parent.difficulty) %>%
  mutate(ts.delta = timestamp - parent.ts) %>%

  mutate(diff.sensitivity = diff.delta / difficulty) %>%
  mutate(ts.sensitivity = ts.delta / timestamp)

current.block <- difficulty$block.number %>% tail(1)
current.bomb <- max(difficulty$bomb)

# difficulty delta vs. block number
difficulty %>%
  sample_n(sample_size) %>%
  group_by(block.bin) %>%
  ggplot(aes(x=block.number)) +
  geom_line(aes(y=diff.delta, color='diff.delta')) +
  geom_line(aes(y=bomb, color='bomb'))

# difficulty sensitivity vs. block number
difficulty %>%
  sample_n(sample_size) %>%
  group_by(block.bin) %>%
  ggplot(aes(x=block.number)) +
  geom_line(aes(y=diff.sensitivity, color='diff.sensitivity'))

difficulty %>%
  group_by(block.bin) %>%
  summarize(sum.diff.delta = sum(diff.delta), na.rm=T) %>%
  ggplot(aes(x=block.bin, y=sum.diff.delta)) +
  geom_line()

difficulty %>%
  group_by(block.bin) %>%
  summarize(sum.diff.delta = sum(diff.delta, na.rm=T), mean.ts.delta = mean(ts.delta, na.rm=T)) %>%
  gather(key = vars, value = val, -block.bin) %>%
  ggplot(aes(x=block.bin, y = val)) +
  geom_line() +
  facet_wrap(facets = 'vars', scales = 'free', ncol = 1)

difficulty %>%
  group_by(block.bin) %>%
  summarize(sum.difficulty = sum(difficulty), sum.diff.delta = sum(diff.delta, na.rm=T), mean.ts.delta = mean(ts.delta, na.rm=T)) %>%
  mutate(percent.delta = sum.diff.delta / sum.difficulty) %>%
  gather(key = vars, value = val, -block.bin) %>%
  ggplot(aes(x=block.bin, y = val)) +
  geom_line() +
  facet_wrap(facets = 'vars', scales = 'free', ncol = 2)

difficulty %>%
  group_by(block.bin) %>%
  summarize(sd = sd(ts.delta, na.rm=T)) %>%
  ggplot(aes(x=block.bin, y=sd)) +
  geom_line()

point_size = 1.0
difficulty %>%
  sample_n(sample_size) %>%
  ggplot(aes(y=diff.sensitivity, x = ts.delta, color = block.number)) +
  geom_point(size = point_size) + 
  scale_color_gradientn(colours = rainbow(10), labels = comma) +
  scale_x_continuous(breaks = -1:8 * 60)

difficulty %>%
  mutate(era = ifelse(block.number <= byzantium.block, 'before byzantium', 'post byzantium')) %>%
  sample_n(sample_size) %>%
  ggplot(aes(y = diff.sensitivity, x = period, color=block.number)) +
  scale_colour_gradient2(low = "red", mid = "green", high = "blue", midpoint = byzantium.block, space = "Lab", na.value = "grey50", guide = "colourbar") +
  geom_point(size = point_size) + 
  facet_wrap(facets = 'era', nrow = 2) +
  geom_vline(xintercept = 39)

difficulty %>%
  sample_n(sample_size) %>%
  ggplot(aes(y = diff.sensitivity, x = period, color=block.number)) +
  scale_colour_gradient2(low = "red", mid = "green", high = "blue", midpoint = byzantium.block, space = "Lab", na.value = "grey50", guide = "colourbar") +
  geom_point(size = point_size) + 
  geom_vline(xintercept = 39)
