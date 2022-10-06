library(jsonlite)
library(tidyverse)
library(ggplot2)

setwd("/Users/jrush/Development/trueblocks-giveth/data/")
cols <- c(
  rep("character", 2),
  "numeric",
  rep("character", 2),
  "numeric",
  rep("character", 7)
)
df <- read.table("summaries/all_donations.csv",
  sep = ",",
  quote = "\"",
  header = TRUE,
  colClasses = cols
)
head(df)

#  filter(type=="eligible") %>%
#  filter(round<"Round15") %>%

result <- df %>%
  mutate(v = valueUsd) %>%
  group_by(currency, round, type) %>%
  mutate(round = str_replace(round, "Round", "")) %>%
  mutate(currency = currency) %>%
  summarize(
    min = min(v),
    max = max(v),
    avg = mean(v),
    sd = sd(v),
    count = n(),
    total = sum(v)
  )
result

p <- ggplot(
  data = result,
  aes(x = round, y = count, colors = type, fill = type)
) +
  ggtitle("Number of Donations per Round") +
  xlab("Round") +
  ylab("Number of Donations") +
  geom_bar(stat = "identity")
p
png()
ggsave("plots/donations-per-round.png")
dev.off()

p <- ggplot(
  data = result,
  aes(x = round, y = total, colors = type, fill = type)
) +
  ggtitle("USD Value of Donations per Round") +
  xlab("Round") +
  ylab("Total Value in USD") +
  geom_bar(stat = "identity")
p
png()
ggsave("plots/usd-value-per-round.png")
dev.off()

result2 <- result
p <- ggplot(
  data = result2,
  aes(x = round, y = count, colors = type, fill = type)
) +
  facet_wrap(facets = "currency", scale = "fixed", ncol = 4) +
  ggtitle("Number of Donations per Round - by Currency") +
  xlab("Round") +
  ylab("Total Value in USD") +
  geom_bar(stat = "identity")
p
png()
ggsave("plots/donations-per-round-per-currency.png")
dev.off()

title <- "Number of Donations per Round - by Currency\nExcluding GIV and XDAI"
result2 <- result2 %>% filter(currency != "GIV" && currency != "XDAI")
p <- ggplot(
  data = result2,
  aes(x = round, y = count, colors = type, fill = type)
) +
  facet_wrap(facets = "currency", scale = "fixed", ncol = 4) +
  ggtitle(title) +
  xlab("Round") +
  ylab("Total Value in USD") +
  geom_bar(stat = "identity")
p
png()
ggsave("plots/donations-per-round-per-currency-no-giv-no-xdai.png")
dev.off()

