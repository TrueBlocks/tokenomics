require(tidyverse)
require(jsonlite)

endpoint <- "http://localhost:8080/"
route <- "status?"
options <- "modes=index&details"
call <- paste0(endpoint, route, options)
call

resp <- fromJSON(call)
df <- as.data.frame(as.data.frame(resp$data$caches)$items)
names(df)

df <- df %>% select(nAddrs, nApps, firstApp, firstTs, indexSizeBytes, bloomSizeBytes)
df <- df %>% filter(nApps >= 2000000)
# df %>% plot()
head(df)

idx_size_to_apps <- df %>% select(indexSizeBytes, nApps)
idx_size_to_apps %>% plot()

bloom_size_to_apps <- df %>% select(bloomSizeBytes, nApps)
bloom_size_to_apps %>% plot()

first_app_to_addrs <- df %>% select(firstApp, nAddrs)
first_app_to_addrs %>% plot()

addrs_to_apps <- df %>% select(nAddrs, nApps)
addrs_to_apps %>% plot()

ts_to_apps <- df %>% select(firstTs, nApps)
ts_to_apps %>% plot()

blk_to_apps <- df %>% select(firstApp, nApps)
blk_to_apps %>% plot()
