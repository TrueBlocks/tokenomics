require(tidyverse)
require(scales)
require(dplyr)
require(magrittr)

df <- read.table("acct-scrape.log", header = TRUE, row.names = NULL)
#df <- df %>% filter(name == "DAO")
#df %>% View()

# plot(df$blksSeen ~ df$blksQueried, df)
# plot(df$blksSeen ~ df$blksHit, df)
# plot(df$blksQueried ~ df$blksHit, df)
df <- df %>% mutate(falsePositive = (blksQueried - blksHit))
df <- df %>% mutate(falsePositivePct = (falsePositive / blksQueried))
df %>%
  ggplot(aes(x=firstBlock)) +
  geom_line(aes(y=blksQueried, color='blksQueried')) +
  geom_line(aes(y=blksHit, color='blksHit')) +
  geom_line(aes(y=falsePositive, color='falsePositive'))

df %>%
  ggplot(aes(x=firstBlock)) +
  geom_line(aes(y=falsePositivePct, color='falsePositivePct'))

df %>%
  group_by(name) %>%
  summarize(fp = sum(falsePositive, na.rm=T), q = sum(blksQueried, na.rm=T), start = min(firstBlock)) %>%
  mutate(fpPct = fp / q) %>%
  ggplot(aes(x = name, y = fpPct)) +
  facet_wrap(facets = 'name', scales = 'free', ncol = 5)
# ggplot(aes(x = name, y = fpPct)) +
  # geom_line(aes(x = name, y=fpPct)) +
  # # facet_wrap(facets = 'name', scales = 'free', ncol = 1)

    # plot(df$blksQueried ~ df$pct.falsePositive, df)
# 
# df2 <- read.table("file", row.names = NULL, header = TRUE)
# plot(df2$txs ~ df2$blk.date)
