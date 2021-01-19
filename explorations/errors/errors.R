require(tidyverse)
require(scales)

df <- read_csv('error-count.csv') %>%
  mutate(pcterrcurr = currErrors / currCount) %>%
  mutate(pcterrtot = totErrors / totCount)

#df <- df %>% filter(blockNum > 150000)

head(df)
tail(df)

df <- df %>% sample_frac(.1)
df %>% plot()

#pctTot <- df %>% select(blockNum, pcterrtot)
#pctTot %>% plot()

#curpct <- df %>% select(blockNum, pcterrcurr)
#curpct %>% plot()

#currCount <- df %>% select(blockNum, currCount)
#currCount %>% plot()

txPerBlock <- df %>% mutate(txPerBlock = totCount / blockNum) %>% mutate(errsPerBlock = totErrors / blockNum) %>% select(blockNum, txPerBlock, errsPerBlock)
head(txPerBlock)
tail(txPerBlock)
txPerBlock %>% plot()
