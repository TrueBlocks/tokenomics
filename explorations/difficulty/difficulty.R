require(tidyverse)
require(scales)
library(lubridate)
library(readr)

#------------------------------------------------------------
# sugar for some named blocks
bn.HOMESTEAD       <- 1150000

bn.BYZANTIUM       <- 4370000
ts.BYZANTIUM       <- 1508131331
off.BYZANTIUM      <- 3000000

bn.CONSTANTINOPLE  <- 7280000
ts.CONSTANTINOPLE  <- 1551383524
off.CONSTANTINOPLE <- off.BYZANTIUM + 2000000

bn.ISTANBUL        <- 9069000
ts.ISTANBUL        <- 1575764709

bn.MUIRGLACIER     <- 9200000
ts.MUIRGLACIER     <- 1577953849
off.MUIRGLACIER    <- off.CONSTANTINOPLE + 4000000

bn.BERLIN          <- 12244000
ts.BERLIN          <- 1618481223

bn.LONDON          <- 12965000
ts.LONDON          <- 1628166822
off.LONDON         <- off.MUIRGLACIER + 700000

bn.ARROW           <- 13773000
ts.ARROW           <- 1639022046
off.ARROW          <- off.LONDON + 1000000

bn.GRAYGLACIER     <- 15050000
ts.GRAYGLACIER     <- 1656586444
off.GRAYGLACIER    <- off.ARROW + 700000
  
bn.SEPT15          <- 15546017
ts.SEPT15          <- 1663243200

# some constants
const.BIN_SIZE     <- 200
const.PERIOD_SIZE  <- 100000
const.SAMPLE_SIZE  <- 50000
const.DANGER_ZONE  <- 38

#------------------------------------------------------------
# read in the data (blocknumber,timestamp,difficulty), removing blocks prior to HOMESTEAD
#
# block.bin  - puts blocks in bukcets of width BIN_SIZE
# block.fake - the fake block number as per the difficulty calc
# period     - the difficulty bomb's current period (relative to block.fake)
# bomb       - the actual bomb's value at the block
setwd("~/Development/tokenomics/explorations/difficulty/")
df <- read_csv('store/difficulty.csv') %>%
  #  filter(blocknumber >= bn.HOMESTEAD) %>%
  mutate(block.bin = floor(blocknumber / const.BIN_SIZE) * const.BIN_SIZE) %>%
  mutate(fake.block =
           ifelse(blocknumber >= bn.GRAYGLACIER,
                  blocknumber - off.GRAYGLACIER,
                  ifelse(blocknumber >= bn.ARROW,
                         blocknumber - off.ARROW,
                         ifelse(blocknumber >= bn.LONDON,
                                blocknumber - off.LONDON,
                                ifelse(blocknumber >= bn.MUIRGLACIER,
                                       blocknumber - off.MUIRGLACIER,
                                       ifelse(blocknumber >= bn.CONSTANTINOPLE,
                                              blocknumber - off.CONSTANTINOPLE,
                                              ifelse(blocknumber >= bn.BYZANTIUM,
                                                     blocknumber - off.BYZANTIUM,
                                                     blocknumber) + 1
                                              )
                                        )
                                )
                          )
                  )
           ) %>%
  mutate(period = floor(fake.block / const.PERIOD_SIZE)) %>%
  mutate(period.scaled = period * 100000) %>%
  mutate(bomb = 2 ^ period) %>%
  
  mutate(parent.difficulty = lag(difficulty)) %>%
  mutate(parent.ts = lag(timestamp)) %>%
  
  mutate(diff.delta = parent.difficulty - difficulty) %>%
  mutate(ts.delta = parent.ts - timestamp) %>%
  
  mutate(diff.sensitivity = diff.delta / difficulty) %>%
  mutate(ts.sensitivity = ts.delta / timestamp) %>%
  
  mutate(era =
           ifelse(blocknumber <= bn.BYZANTIUM,
                  'timeframe 1 (pre-byzantium)',
                  ifelse(blocknumber <= bn.MUIRGLACIER,
                         'timeframe 2 (post-byzantium)',
                         ifelse(blocknumber <= bn.LONDON,
                                'timeframe 3 (post-muir)',
                                ifelse(blocknumber <= bn.ARROW,
                                       'timeframe 3 (post-london)',
                                       ifelse(blocknumber <= bn.GRAYGLACIER,
                                              'timeframe 3 (post-arrow)',
                                              'timeframe 4 (post-grayglacier)'
                                       )
                                )
                         )
                  )
           )
     )

# sample the data otherwise it's too big
sample <- df %>% sample_frac(.005) %>% arrange(blocknumber)
head(sample)
tail(sample)

# group by block bin
blockBinSample <- sample %>% group_by(block.bin)
head(blockBinSample)
tail(blockBinSample)

latest <- max(sample$timestamp)
latest
curFake <- tail(sample$fake.block, n=1)
curFake
latestPeriod <- floor(curFake / 100000)
latestPeriod

#------------------------------------------------------------
chart_title <- "Block Number / Fake Block Number / Bomb Period"
x_vals <- sample$timestamp
x_label <- "Date"
y_vals <- sample$block.bin
y_label <- "Real / Fake BN"
anno1.text <- "Source: Ethereum mainnet"
anno1.x.pct = .15
anno1.y.pct = .01
anno2.text <- "Produced for Tokenomics™ by TrueBlocks, LLC"
anno2.x.pct = .15
anno2.y.pct = .99
source(file="../common/chart_defaults.R")
#------------------------------------------------------------
fakeBlock <- blockBinSample %>%
  ggplot(aes(x = timestamp, cey.lab = 1)) +
  geom_line(aes(y = block.bin,  color='blocknumber')) +
  geom_line(aes(y = fake.block, color='fake.block')) +
  geom_line(aes(y = period.scaled, color='period')) +
  geom_hline(yintercept = (const.DANGER_ZONE * 100000), color="darkgray", linetype="dashed") +
  geom_vline(xintercept = ts.BYZANTIUM, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = ts.CONSTANTINOPLE, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = ts.ISTANBUL, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = ts.MUIRGLACIER, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = ts.BERLIN, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = ts.LONDON, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = ts.ARROW, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = ts.GRAYGLACIER, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = latest, color="blue", linetype="dashed") +
  geom_vline(xintercept = ts.SEPT15, color="red", linetype="dotted") +
  labels + anno1 + anno2 +
  theme + xaxis + yaxis
fakeBlock

#------------------------------------------------------------
chart_title <- "Difficulty and Difficulty Bomb per Block"
x_vals <- blockBinSample$block.bin
x_label <- "Block Number"
y_vals <- blockBinSample$diff.delta
y_label <- "Difficulty / Bomb"

anno1.text <- "Source: Ethereum mainnet"
anno1.x.pct = .1
anno1.y.pct = .4
anno2.text <- "Produced for Tokenomics™ by TrueBlocks, LLC"
anno2.x.pct = .1
anno2.y.pct = .4
source(file="../common/chart_defaults.R")
#------------------------------------------------------------
plot_DeltaDiffPerBlock <- blockBinSample %>%
  ggplot(aes(x=block.bin)) +
  geom_line(aes(y=difficulty), colour='goldenrod') + 
  geom_line(aes(y=bomb * 200), colour='black') + 
  geom_vline(xintercept = bn.BYZANTIUM, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.CONSTANTINOPLE, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.ISTANBUL, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.MUIRGLACIER, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.BERLIN, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.LONDON, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.ARROW, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.GRAYGLACIER, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.SEPT15, color="red", linetype="dotted") +
  labels + anno1 + anno2 +
  theme + xaxis + yaxis
plot_DeltaDiffPerBlock

chart_title <- "Difficulty Delta and Difficulty Bomb per Block"
x_vals <- blockBinSample$block.bin
x_label <- "Block Number"
y_vals <- blockBinSample$diff.delta
y_label <- "Difficulty Delta / Bomb"

anno1.text <- "Source: Ethereum mainnet"
anno1.x.pct = .1
anno2.text <- "Produced for Tokenomics™ by TrueBlocks, LLC"
anno2.x.pct = .1
source(file="../common/chart_defaults.R")
plot_DeltaDiffPerBlock <- blockBinSample %>%
  ggplot(aes(x=block.bin)) +
  geom_line(aes(y=diff.delta), colour='salmon') +
  geom_vline(xintercept = bn.BYZANTIUM, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.CONSTANTINOPLE, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.ISTANBUL, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.MUIRGLACIER, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.BERLIN, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.LONDON, color="lightgray", linetype="dashed") +
  geom_vline(xintercept = bn.SEPT15, color="red", linetype="dotted") +
  geom_line(aes(y=bomb), colour='black') + 
  labels + anno1 + anno2 +
  theme + xaxis + yaxis
plot_DeltaDiffPerBlock

#------------------------------------------------------------
#chart_title <- "Difficulty Sensitivity per Block"
#x_vals <- sample$diff.sensitivity
#x_label <- "Block Number"
#y_vals <- sample$block.bin
#y_label <- "Difficulty Sensitivity"
#source(file="../common/chart_defaults.R")
#------------------------------------------------------------
#plot_SensitivityPerBlock <- blockBinSample %>%
#  ggplot(aes(x=blocknumber)) +
#  geom_line(aes(y=diff.sensitivity), color='salmon') +
#  geom_hline(yintercept = 0, color = "yellow") +
#  theme + labels
#plot_SensitivityPerBlock

grouped_df <- df %>% group_by(block.bin)
grouped_sum_df <- grouped_df %>%
  summarize(
    sum.difficulty = sum(difficulty, na.rm=T),
    sum.diff.delta = sum(diff.delta, na.rm=T)
  )
gathered <- grouped_sum_df %>%
  mutate(percent.delta = sum.diff.delta / sum.difficulty) %>%
  gather(key = vars, value = val, -block.bin)

#gathered %>%
#  ggplot(aes(x=block.bin, y = val)) +
#  geom_line() +
#  facet_wrap(facets = 'vars', scales = 'free', ncol = 1)

point_size = 1.0
#sample %>%
#  filter(abs(ts.delta) < 100) %>%
#  ggplot(aes(y=diff.sensitivity, x = ts.delta, color = blocknumber)) +
#  geom_point(size = point_size) + 
#  scale_color_gradientn(colours = rainbow(5), labels = comma) +
#  scale_x_continuous(breaks = -1:5 * 100)

min.sensitivity = min(sample$diff.sensitivity)
max.sensitivity = max(sample$diff.sensitivity)
mid.sensitivity = (min.sensitivity + max.sensitivity) / 2

sample %>%
  ggplot(aes(y = diff.sensitivity, x = period, color=diff.sensitivity)) +
  scale_colour_gradient2(low = "green",
                         mid = "blue",
                         high = "orange",
                         midpoint = mid.sensitivity,
                         space = "Lab",
                         na.value = "grey50",
                         guide = "colourbar"
  ) +
  geom_point(size = point_size * 2) + 
  facet_wrap(facets = 'era', nrow = 3) +
  geom_vline(xintercept = const.DANGER_ZONE)

latestPeriod
sample %>%
  ggplot(aes(y = diff.sensitivity, x = period, color=block.bin)) +
  scale_colour_gradient2(low = "green",
                         mid = "blue",
                         high = "orange",
                         midpoint = max(sample$blocknumber) / 2,
                         space = "Lab",
                         na.value = "grey50",
                         guide = "colourbar"
  ) +
  geom_point(size = point_size * 
               ifelse(sample$blocknumber > bn.MUIRGLACIER, 4, 
                      ifelse(sample$blocknumber > bn.BYZANTIUM, 0, 0))) + 
  geom_point(size = point_size * 
               ifelse(sample$blocknumber > bn.MUIRGLACIER, 0, 
                      ifelse(sample$blocknumber > bn.BYZANTIUM, 2, 0))) + 
  geom_point(size = point_size * 
               ifelse(sample$blocknumber > bn.MUIRGLACIER, 0, 
                      ifelse(sample$blocknumber > bn.BYZANTIUM, 0, 1))) + 
  geom_vline(xintercept = const.DANGER_ZONE) +
  geom_vline(linetype = 'dotdash', xintercept = latestPeriod)


data <- read_csv("./store/difficulty.csv")
latest <- max(data$timestamp)
as_datetime(latest)

