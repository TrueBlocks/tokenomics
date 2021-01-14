require(readr)
require(dplyr)
require(ggplot2)
require(tidyr)

special.addr <- list(
  'Contract: Foundation Tip Jar' = '0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359',
  'Contract: Unicorn Token' = '0x89205a3a3b2a69de6dbf7f01ed13b2108b2c43e7'
)

names(special.addr[special.addr == '0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359'])

etherTip.base <- read_tsv('../../other_data/etherTip_data.txt') %>% as_tibble()
colnames(etherTip.base) <- etherTip.base %>% colnames() %>% tolower()


## which are unicorn token tx, and which are foundation tip tx?
## keep in mind, many unicorn tx in tip jar traces.

etherTip.w.args <- etherTip.base %>%
  mutate(fn.call = strsplit(articulated, '\\,|\\(|\\)')) %>%
  mutate(args.length = purrr::map_int(fn.call, length))

max.args <- etherTip.w.args %>%
  select(args.length) %>%
  arrange(desc(args.length)) %>%
  top_n(1) %>% 
  unlist() %>%
  unname()

# etherTip$articulated[7] %>% strsplit('\\,(?=([^\"]*\"[^\"]*\")*[^\"]*$)')

## unnest: If you have a list-column, this makes each element of the list its own row. List-columns can either be atomic vectors or data frames.
## not what we want
# etherTip.w.args %>% unnest(args,.sep=".")

etherTip <- etherTip.w.args %>%
  separate(articulated, sep='\\,|\\(|\\)', paste('args', 0:(max.args-1), sep=''), convert = TRUE) %>%
  rename(fn.name = args0) %>%
  mutate(is.fn.call = ifelse(fn.call != '0x', T, F)) %>%
  mutate(have.abi = ifelse(is.fn.call == T & args.length == 1, F, T))

etherTip.fns <- etherTip %>%
  filter(is.fn.call) %>%
  rowwise() %>%
  mutate_at(c('from', 'to', 'args1'), funs(ifelse(. %in% special.addr,
                                         names(special.addr[special.addr == .]),
                                         .))) %>%
  ungroup()

# etherTip.fns %>%
#   filter(have.abi) %>%
#   ggplot(aes(x = fn.name)) + 
#   geom_bar()

# etherTip.fns %>%
#   filter(have.abi) %>%
#   mutate(month = month(datesh), year = year(datesh)) %>%
#   mutate(date = paste(year,month,sep='-')) %>%
#   ggplot(aes(x = date, fill = fn.name)) + 
#   geom_bar()

etherTip.fns %>%
  filter(have.abi) %>%
  ggplot(aes(x = blocknumber, fill = fn.name)) + 
  geom_histogram()

etherTip.fns %>%
  filter(have.abi) %>%
  ggplot(aes(x = blocknumber, fill = fn.name)) + 
  facet_wrap(facets= 'fn.name') +
  geom_histogram()

etherTip.fns %>%
  filter(have.abi) %>%
  filter(to %in% names(special.addr)) %>%
  ggplot(aes(x = blocknumber, fill = fn.name)) +
  facet_wrap('to', nrow = 2) +
  geom_histogram()

etherTip.fns %>%
  filter(to == 'Contract: Unicorn Token') %>%
  filter(fn.name == 'transfer') %>%
  filter(!iserror | blocknumber > 4500000)

etherTip.fns %>%
  filter(fn.name == 'execute') %>%
  View()


etherTip.fns %>%
  filter(!iserror | blocknumber > 4500000) %>%
  filter(to %in% names(special.addr)) %>%
  group_by(blocknumber) %>%
  summarize(eth = sum(ether)) %>%
  mutate(cumsum.eth = cumsum(eth)) %>%
  ggplot(aes(x=blocknumber, y = cumsum.eth)) +
  geom_line()


etherTip.fns %>% View()
