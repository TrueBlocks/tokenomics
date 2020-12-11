# This file is in the public domain
source('init.R')

parity.archive.size %>%
  mutate(size = size / 1e+6) %>%
  ggplot(aes(x = timestamp, y = size)) +
  geom_line()

parity.logs %>%
  ggplot(aes(x=date, y=block)) +
  geom_line() +
  scale_y_continuous(labels = comma, breaks = function(lims) {return(seq(0, lims[2], by = 500000))}) +
  labs(title = "Parity Archive Node w/ Tracing sync progress")


# blockscrape progress (blooms)
blockscrape.logs %>%
  filter(status=="final-b") %>% 
  sample_n(100000) %>%
  ggplot(aes(x=`run-date`, y=blockNum)) +
  geom_line() +
  scale_y_continuous(labels = comma, breaks = function(lims) {return(seq(0, lims[2], by = 500000))})

# blockscrape progress (addr_index)
  
# blockscrape (blooms) vs parity sync
blockscrape.logs.addr.index %>%
  sample_n(100000) %>%
  mutate(time.since.start = `run-date` - blockscrape.logs.addr.index.min.date) %>%
  select(time.since.start, blockNum) %>%
  mutate(type = "blockscrape") %>%
  bind_rows(
    parity.logs %>%
      mutate(time.since.start = date - parity.logs.min.date) %>%
      rename(blockNum = block) %>%
      select(-date) %>%
      mutate(type = "parity")
  ) %>%
  mutate(time.since.start = time.since.start/60/60/24) %>%
  ggplot(aes(x=time.since.start, y=blockNum, color = type)) +
  scale_y_continuous(labels = comma, breaks = function(lims) {return(seq(0, lims[2], by = 500000))}) +
  scale_x_continuous(labels = comma, breaks = function(lims) {return(seq(0, lims[2], by = 1))}) + 
  geom_line() +
  labs(x = "days since start", y = "block number", color = "which program?")

# acctscrape %>%
#   group_by(name) %>%
#   arrange(date) %>%
#   mutate(time.delta = date - lag(date)) %>%
#   ggplot(aes(x=time.delta)) +
#   geom_histogram() +
#   facet_wrap(facets = "name")
