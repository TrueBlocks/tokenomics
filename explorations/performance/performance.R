library(tidyverse)
library(lubridate)

setwd("/Users/jrush/Development/tokenomics/explorations/performance")

df <- read.csv("./store/performance.csv", sep=",", header=TRUE) %>%
    mutate(date = ymd_hms(str_replace(date, "T", " "))) %>%
    mutate(node.epoch = paste(node, "-", epoch))
df1 <- read.csv("./store/performance_failed.csv", sep=",", header=TRUE) %>%
  mutate(date = ymd_hms(str_replace(date, "T", " ")))
#df <- df1

#df <- rbind(df,df1)

df <- df %>%
  mutate(id = row_number()) %>%
  mutate(totSecs = ifelse(group == "all", totSecs / 18, totSecs)) %>%
  filter(cmd != "getBloom") %>%
  filter(cmd != "whereBlock")
#%>%
#  filter(cmd == "acctExport")
  
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
#df <- df %>% filter(epoch != "E-20")
#df <- df %>% filter(epoch != "E-21")
#df <- df %>% filter(epoch != "E-22")
#df <- df %>% filter(epoch != "E-23")
#df <- df %>% filter(epoch != "E-24")
#df <- df %>% filter(epoch != "E-25")
#df <- df %>% filter(epoch != "E-26")
#df <- df %>% filter(epoch != "E-27")
#df <- df %>% filter(epoch != "E-28")
#df <- df %>% filter(epoch != "E-29")
df <- df %>% filter(node == "TG")

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
#df <- df %>% filter(type != "cmd")
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

