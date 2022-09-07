require(tidyverse)
require(scales)
require(dplyr)
require(magrittr)

homestead.block <- 1150000
byzantium.block <- 4370000
kitties.block   <- 4605167
bin_size        <- 200
period_size     <- 100000
sample_size     <- 50000

df <- read_csv('bloom_sizes.csv')
df %>% View()
#  %>% sample_n(250)
df %>%
  ggplot(aes(x=bn)) +
#  geom_line(aes(y=nFiles, color='nFiles')) +
#  geom_line(aes(y=nEmpty, color='nEmpty')) +
#  geom_line(aes(y=nBlooms, color='nBlooms')) +
  geom_line(aes(y=nBits / nBlooms * 50, color='nBits')) +
  geom_line(aes(y=nBits / nVisits * 50, color='nVisits')) +
  geom_vline(xintercept = byzantium.block) +
  geom_vline(xintercept = kitties.block)

plot(df$bn,df$nBits) +
lines(smooth.spline(df$bn, df$nBits, spar=0.35))
