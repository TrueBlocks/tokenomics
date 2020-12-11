# This file is in the public domain
require(readr)
require(dplyr)
require(ggplot2)
require(tidyr)

special.addr <- list(
  'Contract: RChainToken' = '0x168296bb09e24a88805cb9c33356536b980d3fc5',
  'Address: RChain Founder' = '0xe17c20292b2f1b0ff887dc32a73c259fae25f03b',
  'Contract: That popular multisig' = '0x5a0f67a337d8fafded3fa574e7546b529c96df89',
  'Address: Multisig guy 1' = '0xc0895efd056d9a3a81c3da578ada311bfb9356cf',
  'Address: Multisig guy 2' = '0xcf31d3a25dabea7d0e288ce6db4adc4cbc774258'
)

rchain.base <- read_tsv('../../monitors/rchain_data.txt') %>% as_tibble()

colnames(rchain.base) <- rchain.base %>% colnames() %>% tolower()


## which are unicorn token tx, and which are foundation tip tx?
## keep in mind, many unicorn tx in tip jar traces.

rchain.w.args <- rchain.base %>%
  mutate(fn.call = strsplit(articulated, '\\,|\\(|\\)')) %>%
  mutate(args.length = purrr::map_int(fn.call, length))

max.args <- rchain.w.args %>%
  select(args.length) %>%
  arrange(desc(args.length)) %>%
  top_n(1) %>% 
  unlist() %>%
  unname()

# rchain$articulated[7] %>% strsplit('\\,(?=([^\"]*\"[^\"]*\")*[^\"]*$)')

## unnest: If you have a list-column, this makes each element of the list its own row. List-columns can either be atomic vectors or data frames.
## not what we want
# rchain.w.args %>% unnest(args,.sep=".")

rchain <- rchain.w.args %>%
  separate(articulated, sep='\\,|\\(|\\)', paste('args', 0:(max.args-1), sep=''), convert = TRUE) %>%
  rename(fn.name = args0) %>%
  mutate(is.fn.call = ifelse(fn.call != '0x', T, F)) %>%
  mutate(have.abi = ifelse(is.fn.call == T & args.length == 1, F, T))

rchain.fns <- rchain %>%
  filter(is.fn.call) %>%
  rowwise() %>%
  mutate_at(c('from', 'to', 'args1'), funs(ifelse(. %in% special.addr,
                                                  names(special.addr[special.addr == .]),
                                                  .))) %>%
  ungroup()
