# This file is in the public domain
require(tidyverse)
require(scales)
require(magrittr)

homestead.block <- 1150000
byzantium.block <- 4370000

hashrate <- read_csv('average-hashrate-of-the-ethereum-network.csv',
                     col_names = c('date', 'hashrate'),
                     col_types = '??',
                     skip = 1)

bomb <- as_tibble(data.frame(block.number = c(0:7000000))) %>%
  mutate(bomb = ifelse(block.number >= byzantium.block, 2^(floor(abs((block.number - 3000000 + 1)/100000))-2), 2^(floor(abs((byzantium.block + 1)/100000))-2)))

difficulty <- read_csv('difficulty-generated-1a.csv') %>%
  left_join(bomb, by = c('block.number')) %>%
  mutate(era = ifelse(block.number <= byzantium.block, 'pre-byzantium', 'post-byzantium'))

period <- difficulty %>% floor( block.number / 100000 )

current.bomb <- difficulty %>%
  tail(1) %$%
  bomb

difficulty %>%
  mutate(lag.timestamp = lag(timestamp)) %>%
  mutate(block.time.elapsed = timestamp - lag.timestamp) %>%
  mutate(block.bin = floor(block.number/25000)*25000) %>%
  group_by(block.bin) %>%
  summarize(mean.block.time.elapsed = mean(block.time.elapsed)) %>%
  ggplot(aes(x=block.bin, y=mean.block.time.elapsed)) +
  geom_line()

difficulty %>%
  mutate(lag.timestamp = lag(timestamp)) %>%
  mutate(block.time.elapsed = timestamp - lag.timestamp) %>%
  mutate(block.bin = floor(block.number / 25000) * 25000) %>%
  group_by(block.bin) %>%
  summarize(mean.block.time.elapsed = median(block.time.elapsed)) %>%
  ggplot(aes(x=block.bin, y=mean.block.time.elapsed)) +
  geom_line()

difficulty %>%
  mutate(lag.difficulty = lag(difficulty)) %>%
  mutate(difficulty.change = difficulty-lag.difficulty) %>%
  mutate(lag.timestamp = lag(timestamp)) %>%
  mutate(block.time.elapsed = timestamp - lag.timestamp) %>%
  mutate(block.time.elapsed = timestamp - lag.timestamp) %>%
  mutate(block.bin = floor(block.number/25000)*25000) %>%
  group_by(block.bin) %>%
  summarize(sum.difficulty.change = sum(difficulty.change, na.rm=T), mean.block.time.elapsed = mean(block.time.elapsed, na.rm=T)) %>%
  gather(key = vars, value = val, -block.bin) %>%
  ggplot(aes(x=block.bin, y = val)) +
  geom_line() +
  facet_wrap(facets = 'vars', scales = 'free', ncol = 1)

difficulty %>%
  mutate(lag.difficulty = lag(difficulty)) %>%
  mutate(difficulty.change = difficulty-lag.difficulty) %>%
  mutate(lag.timestamp = lag(timestamp)) %>%
  mutate(block.time.elapsed = timestamp - lag.timestamp) %>%
  mutate(block.time.elapsed = timestamp - lag.timestamp) %>%
  mutate(block.bin = floor(block.number/5000)*5000) %>%
  group_by(block.bin) %>%
  summarize(sum.difficulty = sum(difficulty), sum.difficulty.change = sum(difficulty.change, na.rm=T), mean.block.time.elapsed = mean(block.time.elapsed, na.rm=T)) %>%
  mutate(percent.change = sum.difficulty.change / sum.difficulty) %>%
  gather(key = vars, value = val, -block.bin) %>%
  ggplot(aes(x=block.bin, y = val)) +
  geom_line() +
  facet_wrap(facets = 'vars', scales = 'free', ncol = 2)

block.time.stats <- difficulty %>%
  mutate(span = (timestamp - lag(timestamp))) %>%
  filter(!is.na(span)) %>%
  summarize(mean = mean(span),
            median = median(span),
            sd = sd(span))

block.time.stats

## predicting from 6.5m to 7.5m

difficulty %>%
  mutate(span = (timestamp - lag(timestamp))) %>%
  filter(!is.na(span)) %>%
  mutate(block.bin = floor(block.number / 100000) * 100000) %>%
  group_by(block.bin) %>%
  summarize(mean = mean(span),
            median = median(span),
            sd = sd(span)) %>%
  ggplot(aes(x=block.bin, y=sd)) +
  geom_line()

difficulty %>%
  mutate(time.delta = (timestamp - lag(timestamp))) %>%
  mutate(difficulty.delta = (difficulty - lag(difficulty))) %>%
  mutate(difficulty.pct.delta = difficulty.delta / difficulty) %>%
  # filter(block.number >= 1150000) %>%
  # filter(block.number >= 3700000, block.number <= 4370000) %>%
  filter(!is.na(time.delta)) %>%
  sample_n(10000) %>%
  ggplot(aes(y=difficulty.pct.delta, x = time.delta, color = block.number)) +
  geom_point(size = .9) +
  scale_color_gradientn(colours = rainbow(10), labels = comma) +
  scale_x_continuous(breaks = -1:8 * 20)


# difficulty %>%
#   mutate(time.delta = (timestamp - lag(timestamp))) %>%
#   mutate(difficulty.delta = (lag(difficulty) - lag(difficulty, 2))) %>%
#   mutate(difficulty.pct.delta = difficulty.delta / difficulty) %>%
#   filter(!is.na(time.delta)) %>%
#   sample_n(10000) %>%
#   ggplot(aes(y=difficulty.pct.delta, x = time.delta, color = block.number)) +
#   geom_point(size = .9) +
#   scale_color_gradientn(colours = rainbow(10), labels = comma) +
#   scale_x_continuous(breaks = -1:8 * 20)

# difficulty %>%
#   mutate(time.delta = (lag(timestamp) - lag(timestamp,2))) %>%
#   mutate(difficulty.delta = (difficulty - lag(difficulty))) %>%
#   mutate(difficulty.pct.delta = difficulty.delta / difficulty) %>%
#   filter(!is.na(time.delta)) %>%
#   sample_n(10000) %>%
#   ggplot(aes(y=difficulty.pct.delta, x = time.delta, color = block.number)) +
#   geom_point(size = .9) +
#   scale_color_gradientn(colours = rainbow(10), labels = comma) +
#   scale_x_continuous(breaks = -1:8 * 20)

# difficulty %>%
#   mutate(time.delta = (lead(timestamp) - timestamp)) %>%
#   mutate(difficulty.delta = (lead(difficulty) - difficulty)) %>%
#   mutate(difficulty.pct.delta = difficulty.delta / difficulty) %>%
#   filter(!is.na(time.delta)) %>%
#   sample_n(10000) %>%
#   ggplot(aes(y=difficulty.pct.delta, x = time.delta, color = block.number)) +
#   geom_point(size = .9) +
#   scale_color_gradientn(colours = rainbow(10), labels = comma) +
#   scale_x_continuous(breaks = -1:8 * 20)


difficulty %>%
  mutate(time.delta = (timestamp - lag(timestamp))) %>%
  mutate(difficulty = difficulty - bomb) %>%
  mutate(difficulty.delta = (difficulty - lag(difficulty))) %>%
  mutate(difficulty.pct.delta = difficulty.delta / difficulty) %>%
  # filter(block.number >= 1150000) %>%
  # filter(block.number >= 3700000, block.number <= 4370000) %>%
  filter(!is.na(time.delta)) %>%
  sample_n(10000) %>%
  ggplot(aes(y=difficulty.pct.delta, x = time.delta, color = block.number)) +
  geom_point(size = .9) +
  scale_color_gradientn(colours = rainbow(10), labels = comma) +
  scale_x_continuous(breaks = -1:8 * 20)

  
difficulty %>%
  mutate(difficulty.delta = (difficulty - lag(difficulty))) %>%
  mutate(difficulty.pct.delta = difficulty.delta / lag(difficulty)) %>%
  filter(block.number >= homestead.block) %>%
  sample_n(10000) %>%
  ggplot(aes(y=difficulty.pct.delta, x=log(bomb), color=block.number)) +
  # scale_color_gradientn(colours = rainbow(10), labels = comma) +
  scale_colour_gradient2(low = muted("red"), mid = "yellow",
                         high = muted("blue"), midpoint = byzantium.block, space = "Lab",
                         na.value = "grey50", guide = "colourbar") +
  geom_point()




difficulty %>%
  mutate(difficulty.delta = (difficulty - lag(difficulty))) %>%
  mutate(difficulty.pct.delta = difficulty.delta / lag(difficulty)) %>%
  mutate(era = ifelse(block.number <= byzantium.block, 'pre-byzantium', 'zpost-byzantium')) %>%
  # filter(block.number >= homestead.block) %>%
  sample_n(10000) %>%
  ggplot(aes(y=difficulty.pct.delta, x=log(bomb, 2), color=block.number)) +
  scale_colour_gradient2(low = muted("red"), mid = "yellow",
                         high = muted("blue"), midpoint = byzantium.block, space = "Lab",
                         na.value = "grey50", guide = "colourbar") +
  geom_point(size = .7) + 
  facet_wrap(facets = 'era', nrow = 2) +
  geom_vline(xintercept = log(current.bomb, 2))


difficulty %>%
  mutate(time.delta = (timestamp - lag(timestamp))) %>%
  mutate(difficulty.delta = (difficulty - lag(difficulty))) %>%
  mutate(difficulty.pct.delta = difficulty.delta / lag(difficulty)) %>%
  # filter(block.number >= homestead.block) %>%
  sample_n(10000) %>%
  ggplot(aes(y=difficulty.pct.delta * (160), x=log(bomb,2), color=block.number)) +
  scale_colour_gradient2(low = muted("red"), mid = "yellow",
                         high = muted("blue"), midpoint = byzantium.block, space = "Lab",
                         na.value = "grey50", guide = "colourbar") +
  geom_jitter(size = .4, width = .1, height = .01) + 
  facet_wrap(facets = 'era', nrow = 2)
  # geom_vline(xintercept = log(current.bomb, 2))


difficulty %>%
  mutate(difficulty.minus.bomb = difficulty - bomb) %>%
  sample_n(10000) %>%
  ggplot(aes(x=block.number, y=difficulty.minus.bomb)) +
  geom_line()

difficulty %>%
  mutate(bomb.prop = bomb / difficulty) %>%
  # filter(!(block.number >= byzantium.block & block.number <= byzantium.block + 5000)) %>%
  sample_n(100000) %>%
  ggplot(aes(x = log(bomb, 2), y = bomb.prop, color = era)) +
  geom_point() +
  labs(y = "proportion of bomb-effect to total difficulty")




difficulty %>%
  mutate(period = log(bomb, 2)) %>%
  group_by(period, era) %>%
  summarize(timestamp.min = min(timestamp)) %>%
  ggplot(aes(x=timestamp.min, y = 0, col=era, label=period)) +
  geom_point() +
  geom_text(size = 2, nudge_y=.1) +
  ylim(-1,1)


