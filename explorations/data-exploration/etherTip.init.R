require(readr)
require(dplyr)
require(ggplot2)
require(tidyr)

special.addr <- list(
  'Contract: Foundation Tip Jar' = '0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359',
  'Contract: Unicorn Token' = '0x89205a3a3b2a69de6dbf7f01ed13b2108b2c43e7'
)

etherTip.base <- read_tsv('../../monitors/etherTip_data.txt') %>% as_tibble()
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
