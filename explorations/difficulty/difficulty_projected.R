require(tidyverse)
require(scales)
#require(dplyr)
#require(magrittr)

#------------------------------------------------------------
# sugar for some named blocks
named.HOMESTEAD      <- 1150000
named.BYZANTIUM      <- 4370000
named.CONSTANTINOPLE <- 7280000
# some constants
const.BIN_SIZE    <- 200
const.PERIOD_SIZE <- 100000
const.SAMPLE_SIZE <- 50000

#------------------------------------------------------------
# read in the data (blocknumber,timestamp,difficulty), removing blocks prior to HOMESTEAD
#
# block.bin - puts blocks in bukcets of width BIN_SIZE
# block.fake - the fake block number as per the difficulty calc
# period - the difficulty bomb's current period (relative to block.fake)
# bomb - the actual bomb's value at the block
df <- read_csv('data/difficulty.csv') %>%
  filter(blocknumber >= named.HOMESTEAD) %>%
  mutate(block.bin = floor(blocknumber / const.BIN_SIZE) * const.BIN_SIZE) %>%
  mutate(fake.block =
           ifelse(blocknumber >= named.CONSTANTINOPLE,
                  blocknumber - 5000000,
                  ifelse(blocknumber >= named.BYZANTIUM,
                         blocknumber - 3000000,
                         blocknumber) + 1)
  ) %>%
  mutate(period = floor(fake.block / const.PERIOD_SIZE)) %>%
  mutate(period.scaled = period * 100000) %>%
  mutate(bomb = 2 ^ period) %>%
  
  mutate(parent.difficulty = lag(difficulty)) %>%
  mutate(parent.ts = lag(timestamp)) %>%
  
  mutate(diff.delta = parent.difficulty - difficulty) %>%
  mutate(ts.delta = parent.ts - timestamp) %>%
  
  mutate(diff.sensitivity = diff.delta / difficulty) %>%
  mutate(ts.sensitivity = ts.delta / timestamp)

# sample every SAMPLE_SIZE block
sample <- df %>%  sample_frac(.005)

#------------------------------------------------------------
chart_title <- "Block Number / Fake Block Number / Bomb Period"
source <- "Source: Mainnet, November 23, 2019"
x_vals <- sample$timestamp
x_label <- "Date"
y_vals <- sample$block.bin
y_label <- "USD"

#------------------------------------------------------------
source(file="chart_defaults.R")

#------------------------------------------------------------
plot <- sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x = timestamp, cey.lab = 1)) +
  geom_line(aes(y = block.bin,  color='blocknumber')) +
  geom_line(aes(y = fake.block, color='fake.block')) +
  geom_line(aes(y = period.scaled, color='period')) +
  labels + anno1 + anno2 +
  theme + xaxis + yaxis
plot

#------------------------------------------------------------
fn <- "num_fakenum_period.png"

#------------------------------------------------------------
png(paste("./images/", fn), width = 1200, height = 700)
plot
dev.off()

# difficulty delta vs. block number
grouped <- sample %>% group_by(block.bin)

grouped %>%
  ggplot(aes(x=blocknumber)) +
  geom_line(aes(y=diff.delta, color='diff.delta')) +
  geom_line(aes(y=bomb, color='bomb')) + theme


# difficulty sensitivity vs. block number
sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x=blocknumber)) +
  geom_line(aes(y=-diff.sensitivity, color='diff.sensitivity'))

df %>%
  group_by(block.bin) %>%
  summarize(sum.diff.delta = sum(diff.delta), na.rm=T) %>%
  ggplot(aes(x=block.bin, y=sum.diff.delta)) +
  geom_line()

df %>%
  group_by(block.bin) %>%
  summarize(sum.diff.delta = sum(diff.delta, na.rm=T), mean.ts.delta = mean(ts.delta, na.rm=T)) %>%
  gather(key = vars, value = val, -block.bin) %>%
  ggplot(aes(x=block.bin, y = val)) +
  geom_line() +
  facet_wrap(facets = 'vars', scales = 'free', ncol = 1)

df %>%
  group_by(block.bin) %>%
  summarize(sum.difficulty = sum(difficulty), sum.diff.delta = sum(diff.delta, na.rm=T), mean.ts.delta = mean(ts.delta, na.rm=T)) %>%
  mutate(percent.delta = sum.diff.delta / sum.difficulty) %>%
  gather(key = vars, value = val, -block.bin) %>%
  ggplot(aes(x=block.bin, y = val)) +
  geom_line() +
  facet_wrap(facets = 'vars', scales = 'free', ncol = 2)

df %>%
  group_by(block.bin) %>%
  summarize(sd = sd(ts.delta, na.rm=T)) %>%
  ggplot(aes(x=block.bin, y=sd)) +
  geom_line()

point_size = 2.0
sample %>%
  ggplot(aes(y=diff.sensitivity, x = ts.delta, color = blocknumber)) +
  geom_point(size = point_size) + 
  scale_color_gradientn(colours = rainbow(10), labels = comma) +
  scale_x_continuous(breaks = -1:8 * 60)

sample %>%
  mutate(era = ifelse(blocknumber <= named.BYZANTIUM, 'before byzantium', 'post byzantium')) %>%
  ggplot(aes(y = diff.sensitivity, x = period, color=blocknumber)) +
  scale_colour_gradient2(low = "red", mid = "green", high = "blue", midpoint = named.BYZANTIUM, space = "Lab", na.value = "grey50", guide = "colourbar") +
  geom_point(size = point_size) + 
  facet_wrap(facets = 'era', nrow = 2) +
  geom_vline(xintercept = 42)

sample %>%
  ggplot(aes(y = -diff.sensitivity, x = period, color=blocknumber)) +
  scale_colour_gradient2(low = "red", mid = "green", high = "blue", midpoint = named.BYZANTIUM, space = "Lab", na.value = "grey50", guide = "colourbar") +
  geom_point(size = point_size) + 
  geom_vline(xintercept = 42)
