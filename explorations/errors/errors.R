require(tidyverse)
require(scales)

df <- read_csv('error-count.csv') %>%
  mutate(pcterrcurr = currErrors / currCount) %>%
  mutate(pcterrtot = totErrors / totCount) %>%
  filter(blockNum > 300000)

head(df)
tail(df)

df %>% plot()
#df$pcterrtot %>% plot()
##df$pcterrcurr %>% plot()
