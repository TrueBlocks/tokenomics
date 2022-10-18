library(jsonlite)
library(tidyverse)
library(ggplot2)

#setwd("/Users/jrush/Development/trueblocks-giveth/data/")
df <- fromJSON("../data/all/projects.json")
data <- df$data
#View(data)
names(data)

#View(data$id)
#View(data$title)
#View(data$balance)
#View(data$image)
#View(data$slug)
#View(data$slugHistory)
#View(data$creationDate)
#View(data$updatedAt)
#View(data$admin)
#View(data$description)
#View(data$walletAddress)
#View(data$impactLocation)
#View(data$qualityScore)
#View(data$verified)
#View(data$traceCampaignId)
#View(data$listed)
#View(data$givingBlocksId)
#View(data$status)
#View(data$categories)
#View(data$reaction)
#View(data$adminUser)
#View(data$organization)
#View(data$addresses)
#View(data$totalReactions)
#View(data$totalDonations)
#View(data$totalTraceDonations)

data <- data %>% mutate(adminUser.walletAddress = adminUser$walletAddress)
data
s <- data %>% select(title, walletAddress, slug, creationDate, adminUser.walletAddress)
write.csv(s, "./all/s.csv", row.names = FALSE)

# #  filter(type=="eligible") %>%
# #  filter(round<"Round15") %>%

# result <- data %>%
#   mutate(v = valueUsd) %>%
#   group_by(currency, round, type) %>%
#   mutate(round = str_replace(round, "Round", "")) %>%
#   mutate(currency = currency) %>%
#   summarize(min = min(v), max = max(v), avg = mean(v), sd = sd(v), count = n(), total = sum(v))
# result

# p <- ggplot(data=result, aes(x=round, y=count, colors=type, fill=type)) +
#   ggtitle("Number of Donations per Round") +
#   xlab("Round") +
#   ylab("Number of Donations") +
#   geom_bar(stat="identity")
# p
# png()
# ggsave("plots/donations-per-round.png")
# dev.off()

# p <- ggplot(data=result, aes(x=round, y=total, colors=type, fill=type)) +
#   ggtitle("USD Value of Donations per Round") +
#   xlab("Round") +
#   ylab("Total Value in USD") +
#   geom_bar(stat="identity")
# p
# png()
# ggsave("plots/usd-value-per-round.png")
# dev.off()

# result2 <- result
# p <- ggplot(data=result2, aes(x=round, y=count, colors=type, fill=type)) +
#   facet_wrap(facets='currency', scale="fixed", ncol=4) +
#   ggtitle("Number of Donations per Round - by Currency") +
#   xlab("Round") +
#   ylab("Total Value in USD") +
#   geom_bar(stat="identity")
# p
# png()
# ggsave("plots/donations-per-round-per-currency.png")
# dev.off()

# result2 <- result2 %>% filter(currency != "GIV" && currency != "XDAI")
# p <- ggplot(data=result2, aes(x=round, y=count, colors=type, fill=type)) +
#   facet_wrap(facets='currency', scale="fixed", ncol=4) +
#   ggtitle("Number of Donations per Round - by Currency\nExcluding GIV and XDAI") +
#   xlab("Round") +
#   ylab("Total Value in USD") +
#   geom_bar(stat="identity")
# p
# png()
# ggsave("plots/donations-per-round-per-currency-no-giv-no-xdai.png")
# dev.off()

# #txs <- df %>% select(txHash)
# #txs

# #addrs <- df %>%
# #  filter(type == "eligible") %>%
# #  select(round, type, giverAddress, giverName) %>%
# #  group_by(giverAddress, round) %>%
# #  summarize(total = n())
# #addrs <- addrs[order(addrs$total, decreasing = TRUE),]
# #addrs
# #addrs <- df %>%
# #  filter(type == "eligible") %>%
# #  select(round, type, giverAddress, giverName) %>%
# #  group_by(giverAddress) %>%
# #  summarize(total = n())
# #addrs <- addrs[order(addrs$total, decreasing = TRUE),]
# #addrs
