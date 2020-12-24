library(ggplot2)
library(dplyr)
library(ggplot2)

setwd('/Users/jrush/Development/tokenomics/explorations/gitcoin/');

df <- read.csv('./per-grant-tx-counts.csv', header=TRUE)
str(df)
df %>% head

plot <- ggplot(df, aes(x=address, y=count)) +
                 geom_bar(stat = "identity")

plot + ggtitle('Transactions per Day on GitCoin-Splitter') + xlab('Date') + ylab('nTransactions')
