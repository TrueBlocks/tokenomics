require(tidyverse)
require(ggplot2)

data_dir <- "explorations/ethereum-traces/store/"

traces <- readxl::read_xlsx(paste0(data_dir, "traces.xlsx"), range = "A5:CW255") %>%
  rename(nTraces = `...1`) %>%
  gather(block.bucket, occurrences, -nTraces) %>%
  mutate(block.bucket = as.integer(block.bucket))

traces %>%
  # mutate(block.bucket = ntile(block.bucket, 25) * 2000000) %>%
  ggplot(aes(x = block.bucket, y = nTraces, fill = occurrences)) +
  geom_tile(color = "white", size = 0) +
  scale_fill_gradientn(colours = viridis(256, option = "D")) +
  theme_minimal(base_size = 8)

transactions <- readxl::read_xlsx(paste0(data_dir, "transactions.xlsx"), range = "A4:CW254") %>%
  rename(nTraces = `...1`) %>%
  gather(block.bucket, occurrences, -nTraces) %>%
  mutate(nTraces = nTraces * 10) %>%
  mutate(block.bucket = as.integer(block.bucket))

# names(transactions)
#  scale_fill_gradientn(name = "log(n occurrences)", trans="pseudo_log", option = "A") +
transactions %>%
  mutate(block.bucket = ntile(block.bucket, 25) * 2000000) %>%
  ggplot(aes(x = block.bucket, y = nTraces, fill = occurrences)) +
  geom_tile(color = "white", size = 0) +
  scale_fill_gradientn(colours = viridis(256, option = "D")) +
  theme_minimal(base_size = 8)

token_by_week <- read_delim(paste0(data_dir, "tokensByWeek.txt"), delim = "|") %>%
  gather("type", "value", c(-blockNum, -date)) %>%
  mutate(value = as.integer(value))

token_by_week %>%
  ggplot(aes(x = blockNum, y = value, color = type)) +
  geom_line() +
  scale_fill_gradientn(colours = viridis(256, option = "D")) +
  theme_minimal(base_size = 10)

count_by_week <- read_tsv(paste0(data_dir, "countsByWeek.txt")) %>%
  gather("type", "value", c(-blockNum, -date)) %>%
  mutate(value = as.integer(value))

count_by_week %>%
  ggplot(aes(x = blockNum, y = value, color = type)) +
  geom_line() +
  scale_fill_gradientn(colours = viridis(256, option = "D")) +
  theme_minimal(base_size = 10)
