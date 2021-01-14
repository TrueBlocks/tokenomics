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

chifra.status <- paste0(config$apiProvider, "/status?modes=index&details") %>%
  fromJSON(simplifyDataFrame = TRUE) %>%
  as_tibble()
#View(chifra.status)

data <- chifra.status$data
#View(data)

cache <- (data$caches)[[1]]$items[[1]]
#View(caches)

#View(caches[[2]]$items[[1]])
#cache <- caches[[1]]$items[[1]] #%>% filter(grepl('blooms', path))
head(cache)

index.breaks <- cache %>% select(firstAppearance) %>% unlist() %>% unname()
head(index.breaks)

cache %>%
  ggplot(aes(x = firstAppearance, y = bloomSizeBytes)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(
    labels = format_si()
  )
#View(cache)
cache %>%
  mutate(duration = latestTs-firstTs) %>%
  mutate(duration = duration/100/60) %>%
  ggplot(aes(x = firstAppearance, y = duration)) +
  geom_line()


cache %>%
  mutate(duration = latestTs-firstTs) %>%
  filter(firstAppearance > 3e+06) %>%
  ggplot(aes(x = firstAppearance, y = duration)) +
  geom_line() +
  geom_smooth()
