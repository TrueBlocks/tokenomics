# This file is in the public domain
source('ens-init.R')
require('openssl')
require('lubridate')
require('ggridges')
require('tidyr')
rm(base.data)

special.addr <- list(
  'Contract: ENS-Registrar' = '0x6090a6e47849629b7245dfa1ca21d94cd15878ef'
)

hashes <- list(
  'internet.eth' = '2949b355406e040cb594c48726db3cf34bd8f963605e2c39a6b0b862e46825a5',
  'internet.eth.fake' = '6e040cb594c48726db3cf34bd8f963605e2c39a6b0b862e46825a5000000000'
)

exp <- base.exploded %>% sample_n(10000)


exp %>%
    # rowwise() %>%
    # mutate_at(c('from', 'to', 'args1'), funs(ifelse(. %in% special.addr,
    #                                                 names(special.addr[special.addr == .]),
    #                                                 .))) %>%
  mutate(
    fn.name = ifelse(
      fn.name == "unsealBid6090", "unsealBid", ifelse(
        fn.name == "transfer0132", "transfer", fn.name))) %>%
  filter(to == '0x6090a6e47849629b7245dfa1ca21d94cd15878ef') %>%
  filter(arg)
  View()


base.exploded %>% filter(args1 == '2949b355406e040cb594c48726db3cf34bd8f963605e2c39a6b0b862e46825a5' | args2 == '2949b355406e040cb594c48726db3cf34bd8f963605e2c39a6b0b862e46825a5' | args3 == '2949b355406e040cb594c48726db3cf34bd8f963605e2c39a6b0b862e46825a5')

base.exploded %>% filter(args1 == '2949b355406e040cb594c48726db3cf34bd8f963605e2c39a6b0b862e46825a5')

base.exploded %>% View()

internet.eth <- base.exploded %>% filter()


base.exploded %>%
  ggplot(aes(x = as.Date(date), fill = is_error)) +
  geom_bar()


base.exploded %>%
  group_by(is_error) %>%
  summarize(n = n())

sha256('eth')


base.exploded %>% top_n(1000) %>% View()



base.exploded %>% filter(traceid < 10, to == special.addr$`Contract: ENS-Registrar`) %>%
  group_by(is_error, fn.name) %>%
  summarize(n = n()) %>%
  mutate(sum = sum(n)) %>%
  mutate(pct = n / sum) %>% View()


base.exploded %>% filter(traceid < 10, to == special.addr$`Contract: ENS-Registrar`) %>%
  group_by(fn.name, is_error) %>%
  summarize(n = n()) %>%
  mutate(pct = n / sum(n)) %>%
  ungroup() %>%
  filter(substr(fn.name, 1, 2) != '0x') %>%
  mutate(is_error = as.character(is_error)) %>%
  ggplot(aes(x = fn.name, y = pct, fill = is_error)) +
  geom_bar(stat = 'identity', position = 'dodge')

base.exploded %>% filter(traceid < 10, to == special.addr$`Contract: ENS-Registrar`) %>%
  filter(substr(fn.name, 1, 2) != '0x') %>%
  group_by(date) %>%
  #summarize( n = n()) %>%
  ggplot(aes(x = date, fill = fn.name)) + 
  geom_histogram() +
  facet_wrap(facets = 'fn.name')


base.exploded %>%
  filter(traceid == 0,
         to == special.addr$`Contract: ENS-Registrar`,
         fn.name == 'startAuction' | fn.name == 'startAuctions' | fn.name == 'startAuctionsAndBid') %>%
  ggplot(aes(x = date, fill = fn.name)) +
  geom_bar()


base.exploded %>%
  filter(traceid == 0,
         is_error == 0,
         to == special.addr$`Contract: ENS-Registrar`) %>%
  group_by(fn.name) %>%
  summarize(n = n())



internet.eth <- '6e040cb594c48726db3cf34bd8f963605e2c39a6b0b862e46825a50000000000'

base.exploded %>%
  filter(args1 == internet.eth | args2 == internet.eth | args3 == internet.eth, traceid == 0) %>% View()


base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0) %>%
  group_by(from) %>%
  summarize(n = n()) %>%
  arrange(desc(n))

top.10 <- base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0) %>%
  group_by(from) %>%
  summarize(n = n()) %>%
  arrange(desc(n)) %>%
  top_n(10) %>%
  select(from) %>%
  unname() %>%
  unlist()



base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0) %>%
  mutate(is.top.10 = from %in% top.10) %>%
  group_by(is.top.10) %>%
  summarize(n = n()) %>%
  mutate(pct = n / sum(n))


base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0) %>%
  mutate(is.top.10 = from %in% top.10,
         week = week(date)) %>%
  group_by(is.top.10, week) %>%
  summarize(n = n()) %>%
  ggplot(aes(x = week, y = n, color = is.top.10)) +
  geom_line()
  

base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0,
         fn.name == 'finalizeAuction') %>% 
  mutate(month = format(date, '%Y-%m')) %>% 
  group_by(month) %>% 
  summarize(n = n())

base.exploded %>%
  filter(
    fn.name == 'execute',
    is_error == 0
  ) %>% View()

base.exploded %>%
  filter(
    fn.name %in% c('execute', 'newProposalInEther', 'newProposalInWei'),
    is_error == 0,
    traceid == 0
  ) %>% View()

base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0,
         fn.name == 'unsealBid') %>% 
  group_by(args1) %>% 
  summarize(n = n()) %>%
  ggplot(aes(x=n)) +
  geom_histogram()




base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0,
         fn.name == 'unsealBid') %>% 
  group_by(args1) %>% 
  summarize(n = n()) %>%
  mutate(bin = floor(n/10)) %>%
  mutate(prettybin = paste(bin*10, '-', (bin+1)*10-1)) %>%
  arrange(desc(n)) %>%
  group_by(prettybin) %>%
  summarize(n = n())

base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0,
         fn.name == 'unsealBid') %>% 
  group_by(args1) %>% 
  summarize(n = n()) %>%
  mutate(bin = floor(n/10)) %>%
  mutate(prettybin = paste(bin*10, '-', (bin+1)*10-1)) %>%
  ggplot(aes(x=prettybin)) +
  geom_bar()


base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0,
         fn.name == 'unsealBid') %>%
  mutate(month = format(date, '%Y-%m')) %>%
  group_by(month, args1) %>% 
  summarize(n = n()) %>%
  mutate(bin = floor(n/10)) %>%
  mutate(prettybin = paste(bin*10, '-', (bin+1)*10-1)) %>%
  ggplot(aes(x=prettybin)) +
  geom_bar() +
  facet_wrap(facets = 'month')


base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0,
         fn.name == 'unsealBid') %>%
  mutate(month = format(date, '%Y-%m')) %>%
  group_by(month, args1) %>% 
  summarize(n = n()) %>%
  ggplot(aes(x=month, y = n)) +
  geom_boxplot()

base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0,
         fn.name == 'unsealBid') %>%
  mutate(month = format(date, '%Y-%m')) %>%
  group_by(month, args1) %>% 
  summarize(n = n()) %>%
  summarize(median = median(n), mean = mean(n), sd = sd(n))


base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         from %in% top.10,
         is_error == 0,
         traceid == 0) %>%
  ggplot(aes(x=date, y=fn.name, color=from)) +
  geom_point() +
  facet_wrap(facets = 'from')

base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         from %in% top.10,
         is_error == 0,
         traceid == 0) %>%
  mutate(date = as.Date(date)) %>%
  group_by(date, from, fn.name) %>%
  summarize(n = n()) %>%
  ggplot(aes(x=date, y=fn.name, fill=fn.name)) +
  geom_density_ridges() +
  facet_wrap(facets = 'from')


## proportion of bids made vs. unsealed per address

base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0,
         from %in% top.10) %>%
  group_by(from, fn.name) %>%
  summarize(n = n())

base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0,
         from %in% top.10) %>%
  group_by(from, fn.name) %>%
  summarize(n = n())
  
## how many missed reveals did the top 10 users make?  
  base.exploded %>%
  filter(to == special.addr$`Contract: ENS-Registrar`,
         is_error == 0,
         traceid == 0,
         from %in% top.10) %>%
  group_by(from, fn.name) %>%
  summarize(n = n()) %>%
  spread(key = c('fn.name'), value = c('n')) %>%
  mutate_all(funs(ifelse(is.na(.), 0, .))) %>%
  mutate(bid = newBid + startAuctionsAndBid,
         start.auction = startAuction + startAuctions + startAuctionsAndBid) %>%
  mutate(made.vs.unsealed = (bid - unsealBid) / bid) %>%
  select(bid, unsealBid, finalizeAuction, made.vs.unsealed) %>%
  mutate(made.vs.unsealed = format(made.vs.unsealed, digits=2, scientific=FALSE))


## prop of bids made vs bids revealed  
    
  base.exploded %>%
    filter(to == special.addr$`Contract: ENS-Registrar`,
           is_error == 0,
           traceid == 0) %>%
    group_by(from, fn.name) %>%
    summarize(n = n()) %>%
    spread(key = c('fn.name'), value = c('n')) %>%
    mutate_all(funs(ifelse(is.na(.), 0, .))) %>%
    mutate(bid = newBid + startAuctionsAndBid,
           start.auction = startAuction + startAuctions + startAuctionsAndBid) %>%
    mutate(made.vs.unsealed = (bid - unsealBid) / bid) %>%
    select(bid, unsealBid, finalizeAuction, made.vs.unsealed) %>%
    filter(bid > 5) %>%
    arrange(desc(made.vs.unsealed)) %>%
    mutate(made.vs.unsealed = format(made.vs.unsealed, digits=2, scientific=FALSE))
  
  
  base.exploded %>%
    filter(to == special.addr$`Contract: ENS-Registrar`,
           is_error == 0,
           traceid == 0) %>%
    group_by(from, fn.name) %>%
    summarize(n = n()) %>%
    spread(key = c('fn.name'), value = c('n')) %>%
    mutate_all(funs(ifelse(is.na(.), 0, .))) %>%
    mutate(bid = newBid + startAuctionsAndBid,
           start.auction = startAuction + startAuctions + startAuctionsAndBid) %>%
    mutate(made.vs.unsealed = (bid - unsealBid) / bid) %>%
    select(bid, unsealBid, finalizeAuction, made.vs.unsealed) %>%
    filter(bid > 5) %>%
    ggplot(aes(x = made.vs.unsealed)) +
    geom_histogram()
  
  base.exploded %>%
    filter(to == special.addr$`Contract: ENS-Registrar`,
           is_error == 0,
           traceid == 0) %>%
    group_by(from, fn.name) %>%
    summarize(n = n()) %>%
    spread(key = c('fn.name'), value = c('n')) %>%
    mutate_all(funs(ifelse(is.na(.), 0, .))) %>%
    mutate(bid = newBid + startAuctionsAndBid,
           start.auction = startAuction + startAuctions + startAuctionsAndBid) %>%
    mutate(made.vs.unsealed = (bid - unsealBid) / bid) %>%
    select(bid, unsealBid, finalizeAuction, made.vs.unsealed) %>%
    filter(bid > 5) %>%
    ungroup() %>%
    mutate(ntile = ntile(bid, 5)) %>%
    ggplot(aes(x = made.vs.unsealed)) +
    geom_histogram() +
    facet_wrap('ntile')

base.exploded %>%
  filter(traceid == 0,
         fn.name == 'releaseDeed') %>%
  mutate(is_error = as.character(is_error)) %>%
  ggplot(aes(x=date, y=fn.name, color=is_error)) +
  geom_point()
