# "type","round","amount","currency","createdAt","valueUsd","giverAddress","txHash","network",
# "source","giverName","giverEmail","projectLink"

library(jsonlite)
library(tidyverse)
library(ggplot2)

cols <- c(
  rep("character", 2),
  "numeric",
  rep("character", 2),
  "numeric",
  rep("character", 7)
)
df <- read.table("../all/all.csv",
  sep = ",",
  quote = "\"",
  header = TRUE,
  colClasses = cols
)
# View(df)
head(df)

# setwd("/Users/jrush/Development/trueblocks-giveth/data/")
df <- fromJSON("projects/projects.json")
# View(df)
data <- df$data
# View(data)
names(data)

# data$id
# data$title
# data$balance
# data$image
# data$slug
# data$slugHistory
# data$creationDate
# data$updatedAt
# data$admin
# data$description
# data$walletAddress
# data$impactLocation
# data$qualityScore
# data$verified
# data$traceCampaignId
# data$listed
# data$givingBlocksId
# data$status
# data$categories
# data$reaction
# data$adminUser
# data$organization
# data$addresses
# data$totalReactions
# data$totalDonations
# data$totalTraceDonations

#  filter(type=="eligible") %>%
#  filter(round<"Round15") %>%

result <- df %>%
  mutate(v = valueUsd) %>%
  group_by(currency, round, type) %>%
  mutate(round = str_replace(round, "Round", "")) %>%
  mutate(currency = currency) %>%
  summarize(min = min(v), max = max(v), avg = mean(v), sd = sd(v), count = n(), total = sum(v))
result

p <- ggplot(data = result, aes(x = round, y = count, colors = type, fill = type)) +
  ggtitle("Number of Donations per Round") +
  xlab("Round") +
  ylab("Number of Donations") +
  geom_bar(stat = "identity")
p
png()
ggsave("plots/donations-per-round.png")
dev.off()

p <- ggplot(data = result, aes(x = round, y = total, colors = type, fill = type)) +
  ggtitle("USD Value of Donations per Round") +
  xlab("Round") +
  ylab("Total Value in USD") +
  geom_bar(stat = "identity")
p
png()
ggsave("plots/usd-value-per-round.png")
dev.off()

result2 <- result
p <- ggplot(data = result2, aes(x = round, y = count, colors = type, fill = type)) +
  facet_wrap(facets = "currency", scale = "fixed", ncol = 4) +
  ggtitle("Number of Donations per Round - by Currency") +
  xlab("Round") +
  ylab("Total Value in USD") +
  geom_bar(stat = "identity")
p
png()
ggsave("plots/donations-per-round-per-currency.png")
dev.off()

result2 <- result2 %>% filter(currency != "GIV" && currency != "XDAI")
p <- ggplot(data = result2, aes(x = round, y = count, colors = type, fill = type)) +
  facet_wrap(facets = "currency", scale = "fixed", ncol = 4) +
  ggtitle("Number of Donations per Round - by Currency\nExcluding GIV and XDAI") +
  xlab("Round") +
  ylab("Total Value in USD") +
  geom_bar(stat = "identity")
p
png()
ggsave("plots/donations-per-round-per-currency-no-giv-no-xdai.png")
dev.off()

# txs <- df %>% select(txHash)
# txs

# addrs <- df %>%
#  filter(type == "eligible") %>%
#  select(round, type, giverAddress, giverName) %>%
#  group_by(giverAddress, round) %>%
#  summarize(total = n())
# addrs <- addrs[order(addrs$total, decreasing = TRUE),]
# addrs
# addrs <- df %>%
#  filter(type == "eligible") %>%
#  select(round, type, giverAddress, giverName) %>%
#  group_by(giverAddress) %>%
#  summarize(total = n())
# addrs <- addrs[order(addrs$total, decreasing = TRUE),]
# addrs
