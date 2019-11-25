require(tidyverse)
require(scales)

#------------------------------------------------------------
source(file="chart_defaults.R")

difficulty <- read_csv('data/difficulty.csv')

homestead.block <- 1150000
byzantium.block <- 4370000
constantinople.block <- 7280000

bomb <-
  as_tibble(data.frame(blocknumber = c(0:8982000))) %>%
  mutate(bomb =
           ifelse(blocknumber >= constantinople.block,
                  2 ^ ( floor( abs( ( blocknumber - 5000000 + 1) / 100000 ) ) - 2 ),
                  ifelse(blocknumber >= byzantium.block,
                         2 ^ ( floor( abs( ( blocknumber - 3000000 + 1) / 100000 ) ) - 2 ),
                         2 ^ ( floor( abs( ( blocknumber + 1) / 100000 ) ) - 2 )
                  )
           )
  )

bomb.avg <-
  bomb %>%
  mutate(block.bin = floor(blocknumber/25000)*25000) %>%
  group_by(block.bin) %>%
  summarize(mean.bomb = mean(bomb))

#bomb %>%
# ggplot(aes(x=blocknumber, y=bomb)) +
# geom_line()

bomb.avg %>%
  ggplot(aes(x=block.bin, y=mean.bomb)) +
  geom_line() +
  xaxis

avg.difficulty <- difficulty %>%
  mutate(block.bin = floor(blocknumber/25000)*25000) %>%
  group_by(block.bin) %>%
  summarize(mean.difficulty = mean(difficulty))

avg.difficulty %>%
  ggplot(aes(x=block.bin, y=mean.difficulty)) +
  geom_line()


avg.difficulty %>%
  left_join(bomb.avg, by = 'block.bin') %>%
  ggplot(aes(x=block.bin)) +
  geom_line(aes(y=mean.difficulty, color='difficulty')) +
  geom_line(aes(y=mean.bomb, color='bomb'))

difficulty %>%
  mutate(lag.difficulty = lag(difficulty)) %>%
  mutate(difficulty.change = difficulty-lag.difficulty) %>%
  mutate(block.bin = floor(blocknumber/25000)*25000) %>%
  group_by(block.bin) %>%
  summarize(sum.difficulty.change = sum(difficulty.change)) %>%
  ggplot(aes(x=block.bin, y=sum.difficulty.change)) +
  geom_line()

period <- difficulty %>% floor( blocknumber / 100000 )

difficulty %>%
  mutate(lag.timestamp = lag(timestamp)) %>%
  mutate(block.time.elapsed = timestamp - lag.timestamp) %>%
  mutate(block.bin = floor(blocknumber/25000)*25000) %>%
  group_by(block.bin) %>%
  summarize(mean.block.time.elapsed = mean(block.time.elapsed)) %>%
  ggplot(aes(x=block.bin, y=mean.block.time.elapsed)) +
  geom_line()

difficulty %>%
  mutate(lag.timestamp = lag(timestamp)) %>%
  mutate(block.time.elapsed = timestamp - lag.timestamp) %>%
  mutate(block.bin = floor(blocknumber / 25000) * 25000) %>%
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
  mutate(block.bin = floor(blocknumber/25000)*25000) %>%
  group_by(block.bin) %>%
  summarize(sum.difficulty.change = sum(difficulty.change), mean.block.time.elapsed = mean(block.time.elapsed)) %>%
  ggplot(aes(x=sum.difficulty.change, y=mean.block.time.elapsed)) +
  geom_line()


difficulty %>%
  mutate(lag.difficulty = lag(difficulty)) %>%
  mutate(difficulty.change = difficulty-lag.difficulty) %>%
  mutate(lag.timestamp = lag(timestamp)) %>%
  mutate(block.time.elapsed = timestamp - lag.timestamp) %>%
  mutate(block.time.elapsed = timestamp - lag.timestamp) %>%
  mutate(block.bin = floor(blocknumber/25000)*25000) %>%
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
  mutate(block.bin = floor(blocknumber/5000)*5000) %>%
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
  mutate(block.bin = floor(blocknumber / 100000) * 100000) %>%
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
  # filter(blocknumber >= 1150000) %>%
  # filter(blocknumber >= 3700000, blocknumber <= 4370000) %>%
  filter(!is.na(time.delta)) %>%
  sample_n(10000) %>%
  ggplot(aes(y=difficulty.pct.delta, x = time.delta, color = blocknumber)) +
  geom_point(size = .9) +
  scale_color_gradientn(colours = rainbow(10), labels = comma) +
  scale_x_continuous(breaks = -1:8 * 20)


# difficulty %>%
#   mutate(time.delta = (timestamp - lag(timestamp))) %>%
#   mutate(difficulty.delta = (lag(difficulty) - lag(difficulty, 2))) %>%
#   mutate(difficulty.pct.delta = difficulty.delta / difficulty) %>%
#   filter(!is.na(time.delta)) %>%
#   sample_n(10000) %>%
#   ggplot(aes(y=difficulty.pct.delta, x = time.delta, color = blocknumber)) +
#   geom_point(size = .9) +
#   scale_color_gradientn(colours = rainbow(10), labels = comma) +
#   scale_x_continuous(breaks = -1:8 * 20)

# difficulty %>%
#   mutate(time.delta = (lag(timestamp) - lag(timestamp,2))) %>%
#   mutate(difficulty.delta = (difficulty - lag(difficulty))) %>%
#   mutate(difficulty.pct.delta = difficulty.delta / difficulty) %>%
#   filter(!is.na(time.delta)) %>%
#   sample_n(10000) %>%
#   ggplot(aes(y=difficulty.pct.delta, x = time.delta, color = blocknumber)) +
#   geom_point(size = .9) +
#   scale_color_gradientn(colours = rainbow(10), labels = comma) +
#   scale_x_continuous(breaks = -1:8 * 20)

# difficulty %>%
#   mutate(time.delta = (lead(timestamp) - timestamp)) %>%
#   mutate(difficulty.delta = (lead(difficulty) - difficulty)) %>%
#   mutate(difficulty.pct.delta = difficulty.delta / difficulty) %>%
#   filter(!is.na(time.delta)) %>%
#   sample_n(10000) %>%
#   ggplot(aes(y=difficulty.pct.delta, x = time.delta, color = blocknumber)) +
#   geom_point(size = .9) +
#   scale_color_gradientn(colours = rainbow(10), labels = comma) +
#   scale_x_continuous(breaks = -1:8 * 20)


difficulty %>%
  left_join(bomb, by = c('blocknumber')) %>%
  mutate(time.delta = (timestamp - lag(timestamp))) %>%
  mutate(difficulty = difficulty - bomb) %>%
  mutate(difficulty.delta = (difficulty - lag(difficulty))) %>%
  mutate(difficulty.pct.delta = difficulty.delta / difficulty) %>%
  # filter(blocknumber >= 1150000) %>%
  # filter(blocknumber >= 3700000, blocknumber <= 4370000) %>%
  filter(!is.na(time.delta)) %>%
  sample_n(10000) %>%
  ggplot(aes(y=difficulty.pct.delta, x = time.delta, color = blocknumber)) +
  geom_point(size = .9) +
  scale_color_gradientn(colours = rainbow(10), labels = comma) +
  scale_x_continuous(breaks = -1:8 * 20)

difficulty %>%
  left_join(bomb, by = c('blocknumber')) %>%
  mutate(difficulty.delta = (difficulty - lag(difficulty))) %>%
  mutate(difficulty.pct.delta = difficulty.delta / lag(difficulty)) %>%
  filter(blocknumber >= homestead.block) %>%
  sample_n(10000) %>%
  ggplot(aes(y=difficulty.pct.delta, x=log(bomb), color=blocknumber)) +
  # scale_color_gradientn(colours = rainbow(10), labels = comma) +
  scale_colour_gradient2(low = muted("red"), mid = "yellow",
                         high = muted("blue"), midpoint = byzantium.block, space = "Lab",
                         na.value = "grey50", guide = "colourbar") +
  geom_point()


current.bomb <- difficulty %>%
  left_join(bomb, by='blocknumber') %>%
  tail(1) %$%
  bomb

difficulty %>%
  left_join(bomb, by = c('blocknumber')) %>%
  mutate(difficulty.delta = (difficulty - lag(difficulty))) %>%
  mutate(difficulty.pct.delta = difficulty.delta / lag(difficulty)) %>%
  mutate(era = ifelse(blocknumber <= byzantium.block, 'pre-byzantium', 'zpost-byzantium')) %>%
  # filter(blocknumber >= homestead.block) %>%
  sample_n(10000) %>%
  ggplot(aes(y=difficulty.pct.delta, x=log(bomb, 2), color=blocknumber)) +
  scale_colour_gradient2(low = muted("red"), mid = "yellow",
                         high = muted("blue"), midpoint = byzantium.block, space = "Lab",
                         na.value = "grey50", guide = "colourbar") +
  geom_point(size = .7) + 
  facet_wrap(facets = 'era', nrow = 2) +
  geom_vline(xintercept = log(current.bomb, 2))


difficulty %>%
  left_join(bomb, by = c('blocknumber')) %>%
  mutate(time.delta = (timestamp - lag(timestamp))) %>%
  mutate(difficulty.delta = (difficulty - lag(difficulty))) %>%
  mutate(difficulty.pct.delta = difficulty.delta / lag(difficulty)) %>%
  mutate(era = ifelse(blocknumber <= byzantium.block, 'pre-byzantium', 'zpost-byzantium')) %>%
  # filter(blocknumber >= homestead.block) %>%
  sample_n(10000) %>%
  ggplot(aes(y=difficulty.pct.delta * (160), x=log(bomb,2), color=blocknumber)) +
  scale_colour_gradient2(low = muted("red"), mid = "yellow",
                         high = muted("blue"), midpoint = byzantium.block, space = "Lab",
                         na.value = "grey50", guide = "colourbar") +
  geom_jitter(size = .4, width = .1, height = .01) + 
  facet_wrap(facets = 'era', nrow = 2)
  # geom_vline(xintercept = log(current.bomb, 2))


difficulty %>%
  left_join(bomb, by = c('blocknumber')) %>%
  filter(blocknumber >= byzantium.block - 10000, blocknumber <= byzantium.block + 10000) %>%
  View()

difficulty %>%
  left_join(bomb, by = c('blocknumber')) %>%
  mutate(difficulty.minus.bomb = difficulty - bomb) %>%
  sample_n(10000) %>%
  ggplot(aes(x=blocknumber, y=difficulty.minus.bomb)) +
  geom_line()

