library(ggplot2)
library(dplyr)
library(ggplot2)

setwd('/Users/jrush/Development/tokenomics/explorations/gitcoin/');

df <- read.csv('./balances.csv')
df %>% head
df %>% tail

drops <- c('address');
df <- df[ , !(names(df) %in% drops)]
df %>% head
df %>% tail

vals = df %>% group_by(block) %>% summarise_each(funs(n(), total = mean(.)), ether)
vals

plot <- ggplot(vals, aes(x=block, y=total)) + geom_bar(stat = "identity")

plot + ggtitle('Transactions per Day on GitCoin-Splitter') + xlab('Date') + ylab('nTransactions')
