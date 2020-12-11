# This file is in the public domain
require(tidyverse)
require(viridisLite)

data.dir <- "../../trueblocks-tokenomics/other_data/"

countsByWeek <- read_tsv(paste0(data.dir, "countsByWeek.txt"))

  


Traces <- readxl::read_xlsx(paste0(data.dir, "Traces.xlsx"), range = "A5:CW255") %>%
  rename(nTraces = `...1`) %>%
  gather(block.bucket, occurrences, -nTraces) %>%
  mutate(block.bucket = as.integer(block.bucket))

Traces %>%
  #mutate(block.bucket = ntile(block.bucket, 25) * 2000000) %>%
  ggplot(aes(x = block.bucket, y = nTraces, fill = occurrences)) +
  geom_tile(color = "white", size=0) + 
  viridis::scale_fill_viridis(name = "log(n occurrences)", trans="pseudo_log", option = "A", labels=scales::comma) +
  theme_minimal(base_size=8)

tokensByWeek <- read_delim(paste0(data.dir, "tokensByWeek.txt"), delim = "|") %>%
  gather("type", "value", c(-blockNum, -date)) %>%
  mutate(value = as.integer(value))

tokensByWeek %>%
  ggplot(aes(x = blockNum, y = value, color = type)) +
  geom_line() +
  theme_minimal(base_size=10)

