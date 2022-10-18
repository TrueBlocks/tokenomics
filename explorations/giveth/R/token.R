library(httr)
library(jsonlite)
library(tidyverse)
library(ggplot2)

setwd("/Users/jrush/Development/trueblocks-giveth")

cols <- c(rep("numeric",2))
df <- read.table("file.csv", sep=",", quote="\"", header=TRUE, colClasses=cols)
#View(df)
df <- sample_n(df, 50000)
s <- df %>% mutate(bin = floor(blockNumber / 10000) * 10000) %>% group_by(bin) 
#%>% summarize(count = n())
s
s %>% ggplot(aes(x=bin)) + geom_bar()
