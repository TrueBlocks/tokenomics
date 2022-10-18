library(jsonlite)
library(tidyverse)
library(ggplot2)

setwd("/Users/jrush/Development/trueblocks-giveth/data/")
cols <- c(rep("character",2),rep("numeric",3),rep("character",5),rep("numeric",2))
df <- read.table("summaries/all_givbacks.csv", sep=",", quote="\"", header=TRUE, colClasses=cols) %>%
  mutate(givbackUsdValue=as.numeric(givbackUsdValue)) %>%
  mutate(totalDonationsUsdValue=as.numeric(totalDonationsUsdValue))
head(df)

result <- df %>%
  #filter(round >= "Round06") %>%
  mutate(v = totalDonationsUsdValue) %>%
  group_by(round, type) %>%
  mutate(round = str_replace(round, "Round", "")) %>%
  summarize(min = min(v), max = max(v), avg = mean(v), sd = sd(v), count = n(), total = sum(v))
result

p <- ggplot(data=result, aes(x=round, y=count, colors=type, fill=type)) +
  ggtitle("Number of Givbacks per Round") +
  xlab("Round") +
  ylab("Number of Givbacks") +
  geom_bar(stat="identity")
p
#png()
#ggsave("plots/donations-per-round.png")
#dev.off()

p <- ggplot(data=result, aes(x=round, y=total, colors=type, fill=type)) +
  ggtitle("Amount in USD of Givbacks per Round") +
  xlab("Round") +
  ylab("To Value In Usd") +
  geom_bar(stat="identity")
p
#png()
#ggsave("plots/donations-per-round.png")
#dev.off()
