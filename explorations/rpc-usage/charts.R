library(tidyverse)

setwd("/Users/jrush/Development/tokenomics/explorations/rpc-usage/")

df <- read.table("./store/all-counts.csv", sep=",", header=TRUE)
#df <- df %>% filter(without > 4) %>% filter(with > 4)
df

ggplot(df, aes(x=function., y=without, fill=function.)) +
  geom_bar(stat="identity", width=1)

ggplot(df, aes(x=function., y=with, fill=function.)) +
  geom_bar(stat="identity", width=1)

