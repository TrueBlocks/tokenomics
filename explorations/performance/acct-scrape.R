library(tidyverse)
library(lubridate)

setwd("/Users/jrush/Development/tokenomics/explorations/performance")

df <- read.csv("./store/performance_scraper.csv", sep=",", header=TRUE) %>%
  mutate(BIN = ifelse(NFILES < 2000, 4, ifelse(NFILES < 3000, 3, ifelse(NFILES < 4000, 2, 1))))

df <- df %>%
  mutate(id = row_number())

df <- df %>% filter(BIN == 4)
df <- df %>% filter(id > 2500)
#View(df)
#head(df)
#tail(df)
#df <- df %>% filter(BIN != 2)
head(df)
#tail(df)

df <- df %>%
  mutate(PCTSKIPPED = (NSKIPPED * 1.0) / NFILES) %>%
  mutate(PCTFALSE = (NFALSEPOSITIVE * 1.0) / NFILES)
#df <- df %>% filter(PCTFALSE < .1)
df %>% ggplot() +
  geom_point(aes(x = id, y = PCTSKIPPED, color = NCHECKED)) +
  facet_wrap(~BIN)
str(df)
