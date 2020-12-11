# This file is in the public domain
require(tidyverse)
require(jsonlite)
require(curl)
require(ggthemes)
source('./format_si.R')
theme_set(theme_tufte())

config <- list(
  apiProvider = "http://localhost:8080"
)

chifra.status <- paste0(config$apiProvider, "/status?mode_list=index&details") %>%
  fromJSON(simplifyDataFrame = TRUE) %>%
  as_tibble()

blooms.cache <- chifra.status$data[[1]]$caches[[1]]$items[[1]] %>% filter(grepl('blooms', path))

index.breaks <- blooms.cache %>% select(firstAppearance) %>% unlist() %>% unname()

blooms.cache %>%
  ggplot(aes(x = firstAppearance, y = sizeInBytes)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(
    labels = format_si()
  )

index.cache <- chifra.status$data[[1]]$caches[[1]]$items[[1]] %>%
  filter(grepl('finalized', path)) %>%
  as_tibble()

index.cache %>%
  mutate(duration = lastestTs-firstTs) %>%
  mutate(duration = duration/100/60) %>%
  ggplot(aes(x = firstAppearance, y = duration)) +
  geom_line()


index.cache %>%
  mutate(duration = lastestTs-firstTs) %>%
  filter(firstAppearance > 3e+06) %>%
  ggplot(aes(x = firstAppearance, y = duration)) +
  geom_line() +
  geom_smooth()

