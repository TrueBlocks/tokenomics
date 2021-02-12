library(dplyr)
library(ggplot2)

setwd('/Users/jrush/Development/trueblocks-core/src/other/pinata/blooms')

df <- read.table("./zips.csv", sep=",", header=TRUE)
head(df)

changed <- df %>% mutate(id = row_number()) %>% mutate(pct = gz / tar)
#%>% mutate(perBlock = V4 / V15)
#%>%  filter(bn > 200000) %>% filter(bn < 700000)
head(changed)
barplot(changed$pct, las=2)

p <- ggplot(changed, aes(x=tar, y=pct)) +
  geom_point(size=4, shape=1)

p
