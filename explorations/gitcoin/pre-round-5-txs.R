require(tidyverse)

pre_rnd_5 <- read.delim("./store/txs-pre-round-5.csv", sep=',', colClasses="character")
View(pre_rnd_5)

pre_rnd_5 <- pre_rnd_5 %>% mutate(compressedtx = str_replace(compressedtx, "\\(", ",")) %>% separate(compressedtx, tokens, ',')
View(pre_rnd_5)

tok <- pre_rnd_5$tokens
typeof(tok)

pre_rnd_5 <- pre_rnd_5 %>% mutate(ff = tokens[][1])
View(pre_rnd_5)


before <- data.frame(
  attr = c(1, 30 ,4 ,6 ), 
  type = c('foo_and_bar', 'foo_and_bar_2')
)

before %>%
  separate(type, c("foo", "bar"), "_and_")
