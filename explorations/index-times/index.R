library(tidyverse)
library(lubridate)

setwd("/Users/jrush/Development/tokenomics/explorations/index-times")
df <- read.csv("list.txt", sep="|", header=TRUE) %>% mutate(d1 = str_replace(str_replace(str_replace(date, "Dec ", "2020-12-"), "Jan ", "2021-01-"), "Feb ", "2021-02-"))

df <- df %>% mutate(date = ymd_hm(d1))

head(filter(df, df$date > "2021-01-31"), 2)

df <- df %>% select(date, start)                          
df %>% plot()                        
                          
#df <- read.csv("./store/performance_failed.csv", sep=",", header=TRUE) %>%
#  mutate(date = ymd_hms(str_replace(date, "T", " ")))
df <- df %>%
  mutate(id = row_number()) %>%
  mutate(totSecs = ifelse(group == "all", totSecs / 18, totSecs)) %>%
  filter(cmd != "getBloom")

#df <- df %>% filter(epoch != "E-01")
#df <- df %>% filter(epoch != "E-02")
#df <- df %>% filter(epoch != "E-03")
#df <- df %>% filter(epoch != "E-04")
df <- df %>% filter(epoch != "F-01")
df <- df %>% filter(epoch != "F-02")
df <- df %>% filter(epoch != "F-03")
df <- df %>% filter(epoch != "F-04")
#%>% filter(epoch != "E-02")

#df <- df %>% filter(cmd == "acctExport")
#df <- df %>% filter(id > 10000)

#df <- df %>% filter(date > ymd_hms("2021-02-13 00:00:00"))
head(df)
tail(df)

df %>% ggplot(aes(alpha = .1)) +
  geom_smooth(aes(x = id, y = avgSecs * 200, fill = epoch, col = type), method = "loess", formula  = "y ~ x") +
  geom_point(aes(x = id, y = totSecs * 2 + 100, fill = epoch, color = type)) +
  facet_wrap(~cmd)

#two_builds <- df %>% filter(git_hash == "git_f8bb7ac31" | git_hash == "git_4dbb9276c") %>% filter(cmd != "all")
#head(two_builds,2)

#geom_smooth(aes(x = id, y = avgSecs * 200, fill = epoch, col = type), method = "loess", formula  = "y ~ x") +
#two_builds %>% ggplot() +
#  geom_bar(aes(x = git_hash, fill = type, color = type)) +
#  facet_wrap(~cmd)
