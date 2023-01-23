library(tidyverse)
library(lubridate)

# setwd("/Users/jrush/Development/tokenomics/explorations/performance")

desktop <- read.csv("./store/performance.csv", sep=",", header=TRUE)
head(desktop)
web3 <- read.csv("./store/web3.csv", sep=",", header=TRUE)
head(web3)

df <- rbind(desktop, web3)
#df <- web3
#df <- desktop

df <- df %>%
  mutate(date = ymd_hms(str_replace(date, "T", " "))) %>%
  mutate(node.epoch = paste(node, "-", epoch)) %>%
  mutate(cmd.machine = paste(cmd, "-", machine)) %>%
  mutate(id = row_number()) %>%
  mutate(totSecs = ifelse(group == "all", totSecs / 18, totSecs)) %>%
  filter(cmd != "getBloom") %>%
  filter(cmd != "whereBlock")

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
df <- df %>% filter(epoch != "E-14")
df <- df %>% filter(epoch != "E-15")
df <- df %>% filter(epoch != "E-16")
df <- df %>% filter(epoch != "E-17")
df <- df %>% filter(epoch != "E-18")
df <- df %>% filter(epoch != "E-19")
df <- df %>% filter(epoch != "E-20")
df <- df %>% filter(epoch != "E-21")
df <- df %>% filter(epoch != "E-22")
df <- df %>% filter(epoch != "E-23")
df <- df %>% filter(epoch != "E-24")
df <- df %>% filter(epoch != "E-25")
df <- df %>% filter(epoch != "E-26")
df <- df %>% filter(epoch != "E-27")
df <- df %>% filter(epoch != "E-28")
df <- df %>% filter(epoch != "E-29")
df <- df %>% filter(epoch != "E-30")
df <- df %>% filter(epoch != "E-32")
df <- df %>% filter(epoch != "E-35")
df <- df %>% filter(epoch != "E-36")
df <- df %>% filter(epoch != "E-37")
df <- df %>% filter(epoch != "E-38")
df <- df %>% filter(epoch != "E-40")
df <- df %>% filter(epoch != "E-41")
df <- df %>% filter(epoch != "E-42")
#df <- df %>% filter(epoch != "E-43")
#df <- df %>% filter(epoch != "E-44")
#df <- df %>% filter(node == "TG")

df <- df %>% filter(epoch != "E-27") # this was a bogus test
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

df <- df %>% filter(cmd != "ethslurp")
df <- df %>% filter(cmd != "pinMan")

df %>% ggplot(aes(alpha = .1)) +
  geom_smooth(aes(x = id, y = avgSecs * 200, fill = type, col = node.epoch), span = 1, method = "loess", formula  = "y ~ x") +
  geom_point(aes(x = id, y = totSecs * 2 + 100, fill = type, color = node.epoch)) +
  facet_wrap(~cmd)
