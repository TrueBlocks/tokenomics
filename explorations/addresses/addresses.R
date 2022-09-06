library(tidyverse)
library(lubridate)

setwd("/Users/jrush/Development/tokenomics/explorations/addresses")

df <- read.csv("./store/addressesPerTransCount.csv", sep=",", header=TRUE) %>%
  mutate(nTotalTxs = nTxs * nAddrs) %>%
  mutate(isLower = nTxs < 100) %>%
  mutate(isUpper = nTxs > 1000000) %>%
  mutate(isMiddle = !isUpper) %>%
  select(nTxs, nAddrs, nTotalTxs, isLower, isMiddle, isUpper)
View(df %>% filter(isLower))

lower <- df %>% filter(isLower)
upper <- df %>% filter(isUpper)
#middle <- df[!(df1$Name=="George" | df1$Name=="Andrea
middle <- df %>% filter(isMiddle)
head(middle)
tail(middle)

plot(middle %>% filter(nTxs < 1000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 1000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 900) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 1000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 800) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 700) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 500) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 400) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 300) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 200) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 100) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 90) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 80) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 70) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 60) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 50) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 40) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 30) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 20) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 10) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 9) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 8) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 7) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 5) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 4) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 3) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 2) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 1) %>% select(nTxs, nTotalTxs))

middle <- df %>% filter(isMiddle)
#middle <- middle %>% filter(nTxs > 10)
plot(middle %>% filter(nTxs < 1000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 900) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 800) %>% select(nTxs, nTotalTxs))
 plot(middle %>% filter(nTxs < 700) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 500) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 400) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 300) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 200) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 100) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 90) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 80) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 70) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 60) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 50) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 40) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 30) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 20) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 10) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 9) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 8) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 7) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 5) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 4) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 3) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 2) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs < 1) %>% select(nTxs, nTotalTxs))

plot(middle %>% filter(nTxs > 1000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 2000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 3000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 4000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 5000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 6000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 7000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 8000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 9000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 10000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 20000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 30000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 40000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 50000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 60000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 70000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 80000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 90000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 100000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 150000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 250000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 500000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 600000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 700000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 800000) %>% select(nTxs, nTotalTxs))
plot(middle %>% filter(nTxs > 900000) %>% select(nTxs, nTotalTxs))

plot(upper %>% filter(nTxs > 0) %>% select(nTxs, nTotalTxs))
plot(upper %>% filter(nTxs > 5000000) %>% select(nTxs, nTotalTxs))
plot(upper %>% filter(nTxs > 10000000) %>% select(nTxs, nTotalTxs))
plot(upper %>% filter(nTxs > 25000000) %>% select(nTxs, nTotalTxs))
plot(upper %>% filter(nTxs > 50000000) %>% select(nTxs, nTotalTxs))
plot(upper %>% filter(nTxs > 100000000) %>% select(nTxs, nTotalTxs))

plot(df)

merged <- rbind(lower, upper)
merged

merged %>% ggplot(aes(alpha = .1)) +
  geom_bar(aes(x = nTxs, y = nTotalTxs))

chart <- ggpolot(merged)
chart

df <- df %>% filter(epoch != "E-01")
df <- df %>% filter(epoch != "E-02")
df <- df %>% filter(epoch != "E-03")
df <- df %>% filter(epoch != "E-04")
df <- df %>% filter(epoch != "E-05")
df <- df %>% filter(epoch != "E-06")
df <- df %>% filter(epoch != "E-07")
df <- df %>% filter(epoch != "E-08")
df <- df %>% filter(epoch != "E-09")
df <- df %>% filter(epoch != "E-10")
df <- df %>% filter(epoch != "E-11")
df <- df %>% filter(epoch != "E-12")
df <- df %>% filter(epoch != "E-13")
#df <- df %>% filter(epoch != "E-14")
#df <- df %>% filter(node == "TG")

df <- df %>% filter(epoch != "F-01")
df <- df %>% filter(epoch != "F-02")
df <- df %>% filter(epoch != "F-03")
df <- df %>% filter(epoch != "F-04")
df <- df %>% filter(epoch != "F-05")
df <- df %>% filter(epoch != "F-06")
df <- df %>% filter(epoch != "F-07")
df <- df %>% filter(epoch != "F-08")
df <- df %>% filter(epoch != "F-09")
df <- df %>% filter(epoch != "F-10")
df <- df %>% filter(epoch != "F-11")
df <- df %>% filter(epoch != "F-12")

#df <- df %>% filter(cmd == "acctExport")
df <- df %>% filter(type != "cmd")
#df <- df %>% filter(id > 10000)

#df <- df %>% filter(date > ymd_hms("2021-05-10 00:00:00"))
head(df)
tail(df)

df %>% ggplot(aes(alpha = .1)) +
  geom_smooth(aes(x = id, y = avgSecs * 200, fill = type, col = node.epoch), span = 1, method = "loess", formula  = "y ~ x") +
  geom_point(aes(x = id, y = totSecs * 2 + 100, fill = type, color = node.epoch)) +
  facet_wrap(~cmd)

#two_builds <- df %>% filter(git_hash == "git_f8bb7ac31" | git_hash == "git_4dbb9276c") %>% filter(cmd != "all")
#head(two_builds,2)

#geom_smooth(aes(x = id, y = avgSecs * 200, fill = epoch, col = type), method = "loess", formula  = "y ~ x") +
#two_builds %>% ggplot() +
#  geom_bar(aes(x = git_hash, fill = type, color = type)) +
#  facet_wrap(~cmd)

