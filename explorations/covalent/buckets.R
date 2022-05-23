library(tidyverse)
library(gapminder)
library(snpar)
theme_set(theme_bw(base_size=16))

setwd("~/Development/tokenomics/explorations/covalent/")

buckets <- read.csv("./store/buckets.txt", sep = '\t', colClasses = c('integer', 'character'))
buckets

head(buckets)
buckets %>%
  ggplot(aes(x=count))+
  geom_histogram(fill = "dodgerblue",aes(y =..density..)) +
  labs(title="Histogram of counts",
       x= "count")+
  geom_density(col=3)

B <- buckets$bytes
B
barplot(buckets$count, names.arg=B)

alts <- c("two.sided", "less", "greater")
alts

runs.test(buckets$count, exact = FALSE, alternative = alts)
