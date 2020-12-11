require(readxl)
require(dplyr)
require(ggplot2)
require(tidyr)

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

data <- read_excel("ENSUser.xlsx", skip = 3) %>%
  explodeArgs() %>%
  mutate(timestamp = as.POSIXct(timestamp, origin='1970-01-01')) %>%
  mutate(id = row_number())

data %>% View()


data %>%
  filter(trace_id == 0, grepl("ENSUser", from)) %>%
  View()


data %>%
  filter(trace_id == 0, grepl("ENSUser", from)) %>%
  group_by(to) %>%
  summarize(n = n()) %>%
  arrange(desc(n))

data %>%
  filter(trace_id == 0, grepl("ENSUser", from), grepl("ENSRegistrar", to)) %>% View()
  
data %>%
  filter(trace_id == 0, grepl("ENSUser", from), grepl("ENSRegistrar", to)) %>%
  group_by(fn.name) %>%
  summarize(n = n())

data %>%
  filter(trace_id == 0, grepl("ENSUser", from), grepl("ENSRegistrar", to)) %>%
  ggplot(aes(x=timestamp)) +
  geom_density() + 
  facet_wrap(facets = 'fn.name')

data %>%
  filter(trace_id == 0, grepl("ENSUser", from), grepl("ENSRegistrar", to)) %>%
  ggplot(aes(x=timestamp, y=1)) +
  geom_point() + 
  facet_wrap(facets = 'fn.name')


data %>%
  filter(trace_id == 0, grepl("ENSUser", from), grepl("ENSRegistrar", to)) %>% View()

trans_list <- data %>%
  filter(trace_id == 0, grepl("ENSUser", from), grepl("ENSRegistrar", to)) %>%
  mutate(block.trans = paste(block_num, trans_id)) %>%
  select(block.trans)

data %>% filter(paste(block_num, trans_id) %in% trans_list$block.trans) %>% View()
