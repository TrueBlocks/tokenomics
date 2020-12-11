# This file is in the public domain
source('rchain.init.R')

rchain.fns %>% View()

rchain.fns %>%
  filter(fn.name %in% c('transfer', 'transferFrom')) %>%
  ggplot(aes(x = datesh, y = args2)) +
  geom_bar(stat = 'identity')

rchain.fns %>%
  filter(fn.name %in% c('transfer', 'transferFrom')) %>%
  ggplot(aes(x = datesh)) +
  geom_histogram()

