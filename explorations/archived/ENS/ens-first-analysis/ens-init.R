# This file is in the public domain
require(readr)
require(dplyr)
require(ggplot2)
require(tidyr)
require(sparkline)
require(ggridges)
require(DT)
require(lubridate)

special.addr <- list(
  'Contract: ENS-Registrar' = '0x6090a6e47849629b7245dfa1ca21d94cd15878ef',
  'Contract: ENS-EthNameService' = '0x314159265dD8dbb310642f98f50C066173C1259b'
)

base.exploded <- read_tsv('ENS_all.txt') %>% as_tibble() %>% 
  mutate(date = as.POSIXct(strptime(date, format = "%Y-%m-%d %H:%M:%S")))

explodeArgs = function(data) {
  
  # data <- data %>% mutate(articulated = substr(substr(articulated, 1, nchar(articulated)-2), 3, nchar(articulated))
  data <- data %>% mutate(articulated2 = gsub("\"", '', gsub("\\[ ", '', gsub(" \\]", '', articulated)))) # favoring naive approach
  
  data.w.args <- data %>%
    mutate(fn.call = strsplit(articulated2, '\\,|\\(|\\)')) %>%
    mutate(args.length = purrr::map_int(fn.call, length))
  
  max.args <- data.w.args %>%
    select(args.length) %>%
    arrange(desc(args.length)) %>%
    top_n(1) %>% 
    unlist() %>%
    unname()
  
  return(data.w.args %>%
           separate(articulated2, sep='\\, |\\(|\\)', paste('args', 0:(max.args-1), sep=''), convert = TRUE) %>%
           rename(fn.name = args0) %>%
           mutate(is.fn.call = ifelse(fn.name == '0x' | length(fn.name) == 0, F, T)) %>%
           mutate(have.abi = ifelse(is.fn.call == T & args.length == 1, F, T)))
}

fixCrazyData = function(data) {
  data %>%
    mutate(
      fn.name = ifelse(
        fn.name == "unsealBid6090", "unsealBid", ifelse(
          fn.name == "transfer0122", "transfer", fn.name))) %>%
    return()
}

date.cutoff = function(data) {
  data %>%
    filter(date < as.Date('2018-01-01')) %>%
    return()
}

base.exploded <- base.exploded %>%
  explodeArgs() %>%
  fixCrazyData() %>%
  date.cutoff()

# base.exploded <- base.exploded %>% cutoff2018()

# base.data.fn.names
  
  
# base.data %>% select(articulated) %>% mutate(fn.name = articulated[1]) %>% View()


# etherTip.w.args <- etherTip.base %>%
#   mutate(fn.call = strsplit(articulated, '\\,|\\(|\\)')) %>%
#   mutate(args.length = purrr::map_int(fn.call, length))

# max.args <- etherTip.w.args %>%
#   select(args.length) %>%
#   arrange(desc(args.length)) %>%
#   top_n(1) %>% 
#   unlist() %>%
#   unname()

# etherTip <- etherTip.w.args %>%
#   separate(articulated, sep='\\,|\\(|\\)', paste('args', 0:(max.args-1), sep=''), convert = TRUE) %>%
#   rename(fn.name = args0) %>%
#   mutate(is.fn.call = ifelse(fn.call != '0x', T, F)) %>%
#   mutate(have.abi = ifelse(is.fn.call == T & args.length == 1, F, T))

# etherTip.fns <- etherTip %>%
#   filter(is.fn.call) %>%
#   rowwise() %>%
#   mutate_at(c('from', 'to', 'args1'), funs(ifelse(. %in% special.addr,
#                                                   names(special.addr[special.addr == .]),
#                                                   .))) %>%
#   ungroup()
