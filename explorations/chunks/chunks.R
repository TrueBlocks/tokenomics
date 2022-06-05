require(tidyverse)
require(scales)
library(lubridate)
library(readr)
library(httr)
library(jsonlite)

setwd("~/Development/tokenomics/explorations/chunks/")
df <- read_csv('store/chunk_times.csv') %>%
  mutate(previous.timestamp = lag(timestamp)) %>%
  mutate(secs = (timestamp - previous.timestamp)) %>%
  mutate(mins = secs / 60) %>%
  mutate(hours = mins / 60) %>%
  mutate(days = hours / 60) %>%
  mutate(count = 1 / days) %>%
  filter(bn > 5000000) %>%
  filter(bn != (floor(bn / 100000) * 100000 + 1))
df
tail(df)

justGnosis <- df %>% filter(chain == "gnosis")
widGnosis <- max(justGnosis$bn)
widGnosis

justMainnet <- df %>% filter(chain == "mainnet")
widMainnet <- max(justMainnet$bn)
widMainnet

factor <- widGnosis / widMainnet

bnScaled <- df$bn * factor
justMainnet$bn <- justMainnet$bn * factor

all <- rbind(justGnosis, justMainnet)

all %>% ggplot(aes(x = bn, y = days, color = chain)) +
  geom_line() +
  geom_smooth(method = "gam", formula = y ~ s(x, bs = "cs")) 
#+
#  facet_wrap(facets = 'chain', nrow = 2) 
