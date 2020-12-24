require(tidyverse)
require(scales)
require(modules)
require(jsonlite)

setwd("/Users/jrush/Development/tokenomics/")
nb <- use("explorations/common/named_blocks.R")

const.BIN_SIZE    <- 200
const.PERIOD_SIZE <- 100000
const.SAMPLE_SIZE <- 50000

#------------------------------------------------------------
df <- read_csv('data-columns/ethereum-mainnet/combines/by-blocknumber/block-timestamp-difficulty.csv') %>%
  filter(blocknumber > nb$get_bn("homestead")) %>%
  mutate(block.bin = floor(blocknumber / const.BIN_SIZE) * const.BIN_SIZE) %>%
  mutate(ts.diff = timestamp - lag(timestamp))
  

sample <- df %>%  sample_frac(0.05)
chart_title <- "Raw Difficulty (sampled 1 in 100)"
source <- "Source: Tokenomics™ by TrueBlocks"
x_vals <- sample$timestamp
x_label <- ""
y_vals <- sample$ts.diff
y_label <- ""
source(file="explorations/common/chart_defaults.R")
plot <- sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x = timestamp, cey.lab = 1)) +
  geom_vline(xintercept = nb$get_ts("byzantium"), color = "lightgrey") +
  geom_vline(xintercept = nb$get_ts("constantinople"), color = "lightgrey") +
  geom_line(aes(y = ts.diff, color='ts.diff')) +
  geom_hline(yintercept = 14, color = "lightgrey") +
  labels + anno1 + 
  theme + xaxis + yaxis
plot
images <- FALSE
if (images) {
  fn <- "difficulty_raw.png"
  png(paste("tmp-images/", fn), width = 1200, height = 700)
  plot
  dev.off()
}











require(tidyverse)
require(scales)
#require(dplyr)
#require(magrittr)

#------------------------------------------------------------
# sugar for some named blocks
named.HOMESTEAD         <- 1150000
named.BYZANTIUM         <- 4370000
named.BYZANTIUM.ts      <- 1508131331
named.CONSTANTINOPLE    <- 7280000
named.CONSTANTINOPLE.ts <- 1551383524
# some constants
const.BIN_SIZE    <- 200
const.PERIOD_SIZE <- 100000
const.SAMPLE_SIZE <- 50000

#------------------------------------------------------------
df <- read_csv('data/difficulty.csv') %>%
  mutate(block.bin = floor(blocknumber / const.BIN_SIZE) * const.BIN_SIZE) %>%
  mutate(secs.delta = timestamp - lag(timestamp)) %>%
  mutate(secs.delta = ifelse(secs.delta == 14, 1, secs.delta - 14)) %>%
  mutate(secs.grow = ifelse(secs.delta >= 0, secs.delta, 0)) %>%
  mutate(secs.shrink = ifelse(secs.delta < 0, secs.delta, 0))

sample <- df %>%  sample_frac(0.005)

chart_title <- "Change in Seconds Between Blocks Raw Distance from 14 Seconds"
source <- "Source: Mainnet, November 23, 2019"
x_vals <- sample$timestamp
x_label <- ""
y_vals <- (sample$secs.grow)
y_label <- ""
source(file="chart_defaults.R")
plot <- sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x = timestamp, cey.lab = 1)) +
  geom_line(aes(y = secs.grow, color='>= 14 secs')) +
  geom_line(aes(y = secs.shrink, color='< 14 secs')) +
  geom_smooth(aes(y = secs.grow)) +
  geom_vline(xintercept = named.BYZANTIUM.ts, color = "lightgrey") +
  geom_vline(xintercept = named.CONSTANTINOPLE.ts, color = "lightgrey") +
  labels + anno1 + 
  theme + xaxis + yaxis
plot

#------------------------------------------------------------
rel <- 14 #abs(max(df$secs.delta)) #14
df <- df %>%
  mutate(rel.secs.delta = secs.delta / rel) %>%
  mutate(rel.secs.grow = ifelse(rel.secs.delta >= 0, rel.secs.delta, 0)) %>%
  mutate(rel.secs.shrink = ifelse(rel.secs.delta < 0, rel.secs.delta, 0))

sample <- df %>%  sample_frac(0.005)

chart_title <- "Change in Seconds Relative to 14 Seconds"
source <- "Source: Mainnet, November 23, 2019"
x_vals <- sample$timestamp
x_label <- ""
y_vals <- (sample$rel.secs.grow)
y_label <- ""
source(file="chart_defaults.R")
plot <- sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x = timestamp, cey.lab = 1)) +
  geom_line(aes(y = rel.secs.grow, color='>= 14 secs')) +
  geom_line(aes(y = rel.secs.shrink, color='< 14 secs')) +
  geom_vline(xintercept = named.BYZANTIUM.ts, color = "lightgrey") +
  geom_vline(xintercept = named.CONSTANTINOPLE.ts, color = "lightgrey") +
  labels + anno1 + 
  theme + xaxis + yaxis
plot


#------------------------------------------------------------
#------------------------------------------------------------
#------------------------------------------------------------




chart_title <- "Seconds Between Blocks"
source <- "Source: Mainnet, November 23, 2019"
x_vals <- sample$timestamp
x_label <- ""
y_vals <- sample$seconds
y_label <- ""
source(file="chart_defaults.R")
plot <- sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x = timestamp, cey.lab = 1)) +
  geom_line(aes(y = seconds, color='seconds')) +
  labels + anno1 + 
  theme + xaxis + yaxis
plot


mutate(seconds = timestamp - lag(timestamp))


#%>%
#  filter(blocknumber >= named.HOMESTEAD) %>%
##  filter(blocknumber >= named.BYZANTIUM - 200000) %>%
##  filter(blocknumber <= named.BYZANTIUM + 200000) %>%
#  mutate(block.bin = floor(blocknumber / const.BIN_SIZE) * const.BIN_SIZE) %>%
#  
#  mutate(fake.block =
#           ifelse(blocknumber >= named.CONSTANTINOPLE,
#                  blocknumber - 5000000,
#                  ifelse(blocknumber >= named.BYZANTIUM,
#                         blocknumber - 3000000,
#                         blocknumber) + 1)
#  ) %>%
#  mutate(period = floor(fake.block / const.PERIOD_SIZE)) %>%
#  mutate(period.scaled = period * 100000) %>%
#
#  mutate(raw.change.difficulty = lag(difficulty) - difficulty) %>%
#  mutate(rel.change.difficulty = raw.change.difficulty / difficulty) %>%
#
#  mutate(bomb = 2 ^ period) %>%
#  mutate(raw.change.bomb = lag(bomb) - bomb) %>%
#  mutate(rel.bomb = bomb / difficulty) %>%
#
#  mutate(minus = rel.bomb - rel.change.difficulty) %>%
#  
##  mutate(bomb.delta = lag(rel.bomb) - rel.bomb) %>%
##  mutate(ts.sensitivity = ts.delta / timestamp) %>%
##  mutate(stdelta = lag(ts.sensitivity) - ts.sensitivity) %>%
#
#  mutate(non.bomb = (raw.change.difficulty - bomb))
  
# sample every SAMPLE_SIZE block
#fn <- "bomb_and_non_bomb.png"
#png(paste("./images/", fn), width = 1200, height = 700)
#plot
#dev.off()







#------------------------------------------------------------
chart_title <- "Block Number / Fake Block Number / Bomb Period"
source <- "Source: Mainnet, November 23, 2019"
x_vals <- sample$timestamp
x_label <- "Date"
y_vals <- sample$block.bin
y_label <- "USD"
source(file="chart_defaults.R")

#------------------------------------------------------------
plot <- sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x = timestamp, cey.lab = 1)) +
  geom_line(aes(y = non.bomb, color='non.bomb')) +
  geom_line(aes(y = bomb,  color='bomb')) +
  labels + anno1 + anno2 +
  theme + xaxis + yaxis
plot
#fn <- "bomb_and_non_bomb.png"
#png(paste("./images/", fn), width = 1200, height = 700)
#plot
#dev.off()



# difficulty delta vs. block number
grouped <- sample %>% group_by(block.bin)

grouped %>%
  ggplot(aes(x=blocknumber)) +
  geom_line(aes(y=raw.change.difficulty, color='raw.change.difficulty')) +
  geom_line(aes(y=bomb, color='bomb')) + theme


# difficulty sensitivity vs. block number
sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x=blocknumber)) +
  geom_line(aes(y=-rel.change.difficulty, color='rel.change.difficulty'))

df %>%
  group_by(block.bin) %>%
  summarize(sum.raw.change.difficulty = sum(raw.change.difficulty), na.rm=T) %>%
  ggplot(aes(x=block.bin, y=sum.raw.change.difficulty)) +
  geom_line()

df %>%
  group_by(block.bin) %>%
  summarize(sum.raw.change.difficulty = sum(raw.change.difficulty, na.rm=T), mean.ts.delta = mean(ts.delta, na.rm=T)) %>%
  gather(key = vars, value = val, -block.bin) %>%
  ggplot(aes(x=block.bin, y = val)) +
  geom_line() +
  facet_wrap(facets = 'vars', scales = 'free', ncol = 1)

df %>%
  group_by(block.bin) %>%
  summarize(sum.difficulty = sum(difficulty), sum.raw.change.difficulty = sum(raw.change.difficulty, na.rm=T), mean.ts.delta = mean(ts.delta, na.rm=T)) %>%
  mutate(percent.delta = sum.raw.change.difficulty / sum.difficulty) %>%
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
  ggplot(aes(y=rel.change.difficulty, x = ts.delta, color = blocknumber)) +
  geom_point(size = point_size) + 
  scale_color_gradientn(colours = rainbow(10), labels = comma) +
  scale_x_continuous(breaks = -1:8 * 60)

sample %>%
  mutate(era = ifelse(blocknumber <= named.BYZANTIUM, 'before byzantium', 'post byzantium')) %>%
  ggplot(aes(y = rel.change.difficulty, x = period, color=blocknumber)) +
  scale_colour_gradient2(low = "red", mid = "green", high = "blue", midpoint = named.BYZANTIUM, space = "Lab", na.value = "grey50", guide = "colourbar") +
  geom_point(size = point_size) + 
  facet_wrap(facets = 'era', nrow = 2) +
  geom_vline(xintercept = 42)

sample %>%
  ggplot(aes(y = -rel.change.difficulty, x = period, color=blocknumber)) +
  scale_colour_gradient2(low = "red", mid = "green", high = "blue", midpoint = named.BYZANTIUM, space = "Lab", na.value = "grey50", guide = "colourbar") +
  geom_point(size = point_size) + 
  geom_vline(xintercept = 42)











































# https://www.r-bloggers.com/patch-it-up-and-send-it-out/
# Future reference

require(tidyverse)
require(scales)
require(modules)
require(jsonlite)

setwd("/Users/jrush/Development/tokenomics/")
nb <- use("explorations/common/named_blocks.R")

const.BIN_SIZE    <- 200
const.PERIOD_SIZE <- 100000
const.SAMPLE_SIZE <- 50000

#------------------------------------------------------------
df <- read_csv('data-columns/ethereum-mainnet/combines/by-blocknumber/block-timestamp-difficulty.csv') %>%
  filter(blocknumber > nb$get_bn("homestead")) %>%
  mutate(block.bin = floor(blocknumber / const.BIN_SIZE) * const.BIN_SIZE)

sample <- df %>%  sample_frac(0.01)
chart_title <- "Raw Difficulty (sampled 1 in 100)"
source <- "Source: Tokenomics™ by TrueBlocks"
x_vals <- sample$timestamp
x_label <- ""
y_vals <- sample$difficulty
y_label <- ""
source(file="explorations/common/chart_defaults.R")
plot <- sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x = timestamp, cey.lab = 1)) +
  geom_vline(xintercept = nb$get_ts("byzantium"), color = "lightgrey") +
  geom_vline(xintercept = nb$get_ts("constantinople"), color = "lightgrey") +
  geom_vline(xintercept = 1494679592, color = "lightgrey") +
  geom_vline(xintercept = 1496262791, color = "lightgrey") +
  geom_vline(xintercept = 1497906023, color = "lightgrey") +
  geom_vline(xintercept = 1499633567, color = "lightgrey") +
  geom_vline(xintercept = 1501511212, color = "lightgrey") +
  geom_vline(xintercept = 1503608908, color = "lightgrey") +
  geom_vline(xintercept = 1506036497, color = "lightgrey") +
  geom_vline(xintercept = 1549752194, color = "lightgrey") +
  geom_hline(yintercept = 2467219275799990, color = "lightgrey") +
  geom_line(aes(y = difficulty, color='difficulty')) +
  labels + anno1 + 
  theme + xaxis + yaxis
plot
images <- FALSE
if (images) {
  fn <- "difficulty_raw.png"
  png(paste("tmp-images/", fn), width = 1200, height = 700)
  plot
  dev.off()
}

#------------------------------------------------------------
df <- df %>%
  mutate(diff.delta = difficulty - lag(difficulty)) %>%
  mutate(diff.grow = ifelse(diff.delta >= 0, diff.delta, 0)) %>%
  mutate(diff.shrink = ifelse(diff.delta < 0, diff.delta, 0))
sample <- df %>%  sample_frac(0.01)
chart_title <- "Raw Change in Difficulty (sampled 1 in 100)"
source <- "Source: Mainnet, November 23, 2019"
x_vals <- sample$timestamp
x_label <- ""
y_vals <- (sample$diff.grow / 1000000000)
y_label <- ""
source(file="explorations/common/chart_defaults.R")
plot <- sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x = timestamp, cey.lab = 1)) +
  geom_line(aes(y = diff.grow, color='diff.grow')) +
  geom_line(aes(y = diff.shrink, color='diff.shrink')) +
  geom_vline(xintercept = nb$get_ts("byzantium"), color = "lightgrey") +
  geom_vline(xintercept = nb$get_ts("constantinople"), color = "lightgrey") +
  labels + anno1 + 
  theme + xaxis + yaxis
plot
if (images) {
  fn <- "difficulty_delta.png"
  png(paste("tmp-images/", fn, sep = ""), width = 1200, height = 700)
  plot
  dev.off()
}

#------------------------------------------------------------
df <- df %>%
  mutate(rel.diff.delta = (difficulty - lag(difficulty)) / difficulty) %>%
  mutate(rel.diff.grow = ifelse(rel.diff.delta >= 0, rel.diff.delta, 0)) %>%
  mutate(rel.diff.shrink = ifelse(rel.diff.delta < 0, rel.diff.delta, 0))

sample <- df %>%  sample_frac(0.05)
chart_title <- "Change in Difficulty in Relation to Total Difficulty (sampled 1 in 20)"
source <- "Source: Mainnet, November 23, 2019"
x_vals <- sample$timestamp
x_label <- ""
y_vals <- (sample$rel.diff.grow / 1000000000)
y_label <- ""
source(file="explorations/common/chart_defaults.R")
plot <- sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x = timestamp, cey.lab = 1)) +
  geom_line(aes(y = rel.diff.grow, color='rel.diff.grow')) +
  geom_line(aes(y = rel.diff.shrink, color='rel.diff.shrink')) +
  geom_vline(xintercept = nb$get_ts("byzantium"), color = "lightgrey") +
  geom_vline(xintercept = nb$get_ts("constantinople"), color = "lightgrey") +
  labels + anno1 + 
  theme + xaxis + yaxis
plot
if (images) {
  fn <- "difficulty_relative.png"
  png(paste("tmp-images/", fn), width = 1200, height = 700)
  plot
  dev.off()
}

l <- nb$get_bn("constantinople") - 400000
u <- nb$get_bn("constantinople") + 200000

sample <- df %>%
  sample_frac(0.05) %>%
  filter(blocknumber > l) %>%
  filter(blocknumber < u)

chart_title <- "Change in Difficulty in Relation to Total Difficulty (sampled 1 in 20)"
source <- "Source: Mainnet, November 23, 2019"
x_vals <- sample$timestamp
x_label <- ""
y_vals <- (sample$rel.diff.grow / 1000000000)
y_label <- ""
source(file="explorations/common/chart_defaults.R")
plot <- sample %>%
  group_by(block.bin) %>%
  ggplot(aes(x = timestamp, cey.lab = 1)) +
  geom_line(aes(y = rel.diff.grow, color='rel.diff.grow')) +
  geom_line(aes(y = rel.diff.shrink, color='rel.diff.shrink')) +
  geom_vline(xintercept = nb$get_ts("byzantium"), color = "lightgrey") +
  geom_vline(xintercept = nb$get_ts("constantinople"), color = "lightgrey") +
  labels + anno1 + 
  theme + xaxis + yaxis
plot
if (images) {
  fn <- "difficulty_relative.png"
  png(paste("tmp-images/", fn), width = 1200, height = 700)
  plot
  dev.off()
}

if (FALSE) {
  
  df <- read_csv('data/difficulty.csv') %>%
    mutate(block.bin = floor(blocknumber / const.BIN_SIZE) * const.BIN_SIZE) %>%
    mutate(fake.block =
             ifelse(blocknumber >= nb$get_bn("constantinople"),
                    blocknumber - 5000000,
                    ifelse(blocknumber >= nb$get_bn("byzantium"),
                           blocknumber - 3000000,
                           blocknumber) + 1)
    ) %>%
    mutate(period = floor(fake.block / const.PERIOD_SIZE)) %>%
    mutate(period.scaled = period * 100000) %>%
    mutate(bomb = 2 ^ period)
  sample <- df %>%  sample_frac(0.05)
  chart_title <- "Bomb (with Fake Block)"
  source <- "Source: Mainnet, November 23, 2019"
  x_vals <- sample$timestamp
  x_label <- ""
  y_vals <- sample$seconds
  y_label <- ""
  source(file="chart_defaults.R")
  plot <- sample %>%
    group_by(block.bin) %>%
    ggplot(aes(x = timestamp, cey.lab = 1)) +
    geom_line(aes(y = bomb, color='bomb')) +
    labels + anno1 + 
    theme + xaxis + yaxis
  plot
  fn <- "bomb_fake.png"
  png(paste("tmp-images/", fn), width = 1200, height = 700)
  plot
  dev.off()
  
  mutate(seconds = timestamp - lag(timestamp))
  
  
  #%>%
  #  filter(blocknumber >= nb$get_bn("homestead")) %>%
  ##  filter(blocknumber >= nb$get_bn("byzantium") - 200000) %>%
  ##  filter(blocknumber <= nb$get_bn("byzantium") + 200000) %>%
  #  mutate(block.bin = floor(blocknumber / const.BIN_SIZE) * const.BIN_SIZE) %>%
  #  
  #  mutate(fake.block =
  #           ifelse(blocknumber >= nb$get_bn("constantinople"),
  #                  blocknumber - 5000000,
  #                  ifelse(blocknumber >= nb$get_bn("byzantium"),
  #                         blocknumber - 3000000,
  #                         blocknumber) + 1)
  #  ) %>%
  #  mutate(period = floor(fake.block / const.PERIOD_SIZE)) %>%
  #  mutate(period.scaled = period * 100000) %>%
  #
  #  mutate(raw.change.difficulty = lag(difficulty) - difficulty) %>%
  #  mutate(rel.change.difficulty = raw.change.difficulty / difficulty) %>%
  #
  #  mutate(bomb = 2 ^ period) %>%
  #  mutate(raw.change.bomb = lag(bomb) - bomb) %>%
  #  mutate(rel.bomb = bomb / difficulty) %>%
  #
  #  mutate(minus = rel.bomb - rel.change.difficulty) %>%
  #  
  ##  mutate(bomb.delta = lag(rel.bomb) - rel.bomb) %>%
  ##  mutate(ts.sensitivity = ts.delta / timestamp) %>%
  ##  mutate(stdelta = lag(ts.sensitivity) - ts.sensitivity) %>%
  #
  #  mutate(non.bomb = (raw.change.difficulty - bomb))
  
  # sample every SAMPLE_SIZE block
  #fn <- "bomb_and_non_bomb.png"
  #png(paste("./images/", fn), width = 1200, height = 700)
  #plot
  #dev.off()
  
  
  
  
  
  
  #require(dplyr)
  #require(magrittr)
  
  #------------------------------------------------------------
  chart_title <- "Block Number / Fake Block Number / Bomb Period"
  source <- "Source: Mainnet, November 23, 2019"
  x_vals <- sample$timestamp
  x_label <- "Date"
  y_vals <- sample$block.bin
  y_label <- "USD"
  source(file="chart_defaults.R")
  
  #------------------------------------------------------------
  plot <- sample %>%
    group_by(block.bin) %>%
    ggplot(aes(x = timestamp, cey.lab = 1)) +
    geom_line(aes(y = non.bomb, color='non.bomb')) +
    geom_line(aes(y = bomb,  color='bomb')) +
    labels + anno1 + anno2 +
    theme + xaxis + yaxis
  plot
  #fn <- "bomb_and_non_bomb.png"
  #png(paste("./images/", fn), width = 1200, height = 700)
  #plot
  #dev.off()
  
  
  
  # difficulty delta vs. block number
  grouped <- sample %>% group_by(block.bin)
  
  grouped %>%
    ggplot(aes(x=blocknumber)) +
    geom_line(aes(y=raw.change.difficulty, color='raw.change.difficulty')) +
    geom_line(aes(y=bomb, color='bomb')) + theme
  
  
  # difficulty sensitivity vs. block number
  sample %>%
    group_by(block.bin) %>%
    ggplot(aes(x=blocknumber)) +
    geom_line(aes(y=-rel.change.difficulty, color='rel.change.difficulty'))
  
  df %>%
    group_by(block.bin) %>%
    summarize(sum.raw.change.difficulty = sum(raw.change.difficulty), na.rm=T) %>%
    ggplot(aes(x=block.bin, y=sum.raw.change.difficulty)) +
    geom_line()
  
  df %>%
    group_by(block.bin) %>%
    summarize(sum.raw.change.difficulty = sum(raw.change.difficulty, na.rm=T), mean.ts.delta = mean(ts.delta, na.rm=T)) %>%
    gather(key = vars, value = val, -block.bin) %>%
    ggplot(aes(x=block.bin, y = val)) +
    geom_line() +
    facet_wrap(facets = 'vars', scales = 'free', ncol = 1)
  
  df %>%
    group_by(block.bin) %>%
    summarize(sum.difficulty = sum(difficulty), sum.raw.change.difficulty = sum(raw.change.difficulty, na.rm=T), mean.ts.delta = mean(ts.delta, na.rm=T)) %>%
    mutate(percent.delta = sum.raw.change.difficulty / sum.difficulty) %>%
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
    ggplot(aes(y=rel.change.difficulty, x = ts.delta, color = blocknumber)) +
    geom_point(size = point_size) + 
    scale_color_gradientn(colours = rainbow(10), labels = comma) +
    scale_x_continuous(breaks = -1:8 * 60)
  
  sample %>%
    mutate(era = ifelse(blocknumber <= nb$get_bn("byzantium"), 'before byzantium', 'post byzantium')) %>%
    ggplot(aes(y = rel.change.difficulty, x = period, color=blocknumber)) +
    scale_colour_gradient2(low = "red", mid = "green", high = "blue", midpoint = nb$get_bn("byzantium"), space = "Lab", na.value = "grey50", guide = "colourbar") +
    geom_point(size = point_size) + 
    facet_wrap(facets = 'era', nrow = 2) +
    geom_vline(xintercept = 42)
  
  sample %>%
    ggplot(aes(y = -rel.change.difficulty, x = period, color=blocknumber)) +
    scale_colour_gradient2(low = "red", mid = "green", high = "blue", midpoint = nb$get_bn("byzantium"), space = "Lab", na.value = "grey50", guide = "colourbar") +
    geom_point(size = point_size) + 
    geom_vline(xintercept = 42)
}
