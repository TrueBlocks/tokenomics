library(ggplot2)
library(dplyr)
library(ggplot2)

setwd('/Users/jrush/Development/tokenomics/explorations/gitcoin/');

df <- read.csv('./txs-per-day.csv', header=TRUE)
str(df)
df %>% head

min <- as.Date("2019-09-15")
max <- as.Date("2020-05-15")

df <- df %>% mutate(d = as.Date(date)) %>% filter(d > min) %>% filter(d < max)
df %>% head()
df %>% tail()

df <- df %>% mutate(round = ifelse(d < as.Date("2020-01-01"), 'round3', ifelse(d > as.Date("2020-02-28"), 'round5', 'round4')))
df %>% head()
df %>% tail()

plot <- ggplot(df, aes(x=d, y=count, fill=round)) +
                 scale_x_date(date_labels = "%b %Y", limits = c(min, max)) +
                 geom_bar(stat = "identity")


plot + ggtitle('Transactions per Day on GitCoin-Splitter') + xlab('Date') + ylab('nTransactions')
