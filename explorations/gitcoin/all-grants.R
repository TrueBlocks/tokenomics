require(tidyverse)

payouts <- read.delim("./store/payouts.csv", sep=',')
payouts <- payouts %>% mutate(token = str_split(compressedlog, "\\("))
head(payouts)

tok <- payouts$token
View(tok)
 d