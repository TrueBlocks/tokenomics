library(tidyverse)
library(gapminder)
library(snpar)
theme_set(theme_bw(base_size=16))

setwd("~/Development/tokenomics/explorations/covalent/")

buckets <- read.csv("./store/buckets.txt", sep = '\t', colClasses = c('integer', 'character'))
head(buckets)

barplot(buckets$count, names.arg=buckets$bytes)
