# This file is in the public domain
require(tidyverse)
require(plotrix)

txs1 <- read_tsv('speed.txt', col_names = c("1","2","3","4","5","6","7","8","9"))
txs1 <- txs1 %>% mutate(mean = rowMeans(txs1[,-1])) %>% mutate(row = row_number())
txs1 %>% ggplot(aes(x=row, y=txs1$mean)) + geom_smooth()

txs2 <- read_tsv('speed2.txt', col_names = c("1","2","3","4","5","6","7","8","9"))
txs2 <- txs2 %>% mutate(mean = rowMeans(txs2[,-1])) %>% mutate(row = row_number())
txs2 %>% ggplot(aes(x=row, y=txs2$mean)) + geom_smooth()

joined <- inner_join(txs1, txs2, by = "row")
joined %>%
  ggplot(aes(x=row, y=joined$mean.x)) + 
  geom_smooth() +
  ggplot(aes(x=row, y=joined$mean.y)) +
  geom_smooth()
  
