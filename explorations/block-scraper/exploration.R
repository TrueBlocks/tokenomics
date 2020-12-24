require(tidyverse)
require(scales)
require(dplyr)
require(magrittr)

homestead.block <- 1150000
byzantium.block <- 4370000
bin_size        <- 10000
period_size     <- 100000
sample_size     <- 25000

tx_counts <- read_csv('tx_counts.csv') %>%
    mutate(block.bin = floor(block.number / bin_size) * bin_size)

tx_counts <- tx_counts %>%
  group_by(block.bin) %>%
  summarize(sum.count = sum(tx.cnt))

tx_counts %>%
  ggplot(aes(x=block.bin)) +
  geom_line(aes(y=(sum.count/bin_size), color='sum.count'))

tx_counts %>%
  ggplot(aes(x=block.bin, y=(sum.count/bin_size)) +
  geom_line()

write_excel_csv(tx_counts, "./tx_counts.xlsx")
  
tr_counts <- read_csv('tr_counts.csv') %>%
  mutate(block.bin = floor(block.number / bin_size) * bin_size)
depth <- read_csv('depth.csv') %>%
  mutate(block.bin = floor(block.number / bin_size) * bin_size)
addrs <- read_csv('addrs.csv') %>%
  mutate(block.bin = floor(block.number / bin_size) * bin_size)
uniq <- read_csv('uniq.csv') %>%
  mutate(block.bin = floor(block.number / bin_size) * bin_size)



tx_counts %>%
  sample_n(sample_size) %>%
  group_by(block.bin) %>%
  ggplot(aes(x=block.bin)) +
  geom_line(aes(y=tx.cnt, color='tx.cnt'))
tr_counts %>%
  sample_n(sample_size) %>%
  ggplot(aes(x=block.number)) +
  geom_line(aes(y=tr.cnt, color='tr.cnt'))
depth %>%
  sample_n(sample_size) %>%
  ggplot(aes(x=block.number)) +
  geom_line(aes(y=tr_d, color='tr_d'))
addrs %>%
  sample_n(sample_size) %>%
  ggplot(aes(x=block.number)) +
  geom_line(aes(y=n_add, color='n_add'))
uniq %>%
  sample_n(sample_size) %>%
  ggplot(aes(x=block.number)) +
  geom_point(aes(y=u_add, color='u_add'))

difficulty <- read_csv('difficulty-generated-1a.csv') %>%
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



# hash rate calcs
hashrate <- read_csv('average-hashrate-of-the-ethereum-network.csv',
                     col_names = c('date', 'hashrate'),
                     col_types = '??',
                     skip = 1)
hashrate %>%
  ggplot(aes(x=date, y=hashrate, color=hashrate)) +
  scale_color_gradientn(colours = rainbow(10), labels = comma) +
  geom_line()

# Vatlik's python calc of expected difficulty
vitalik_pre_byzantium = read_csv('vitalik_pre_byzantium.csv')
vitalik_pre_byzantium %>%
  ggplot(aes(x=block.number)) +
  geom_line(aes(y=block_time))

compare <- left_join(difficulty, vitalik_pre_byzantium, by = 'block.number')
compare %>%
  filter( block.number <= max(vitalik_pre_byzantium$block.number) ) %>%
  filter( block.number >= min(vitalik_pre_byzantium$block.number) ) %>%
  filter( mod(block.number, 10000) == 0) %>%
  ggplot(aes(x=block.number)) +
  geom_line(aes(y=block_time)) +
  geom_line(aes(y=ts.delta))

