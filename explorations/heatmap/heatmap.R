require(tidyverse)
require(jsonlite)

endpoint <- "http://localhost:8080/"
route <- "status?"
options <- "mode=index&details"
call <- paste0(endpoint, route, options);
call

resp <- fromJSON(call)
df <- as.data.frame(as.data.frame(resp$data$caches)$items)
# View(df)

df <- df %>% select(nAddresses, nAppearances, firstAppearance, firstTs, indexSizeBytes, bloomSizeBytes);
df %>% plot()

idxSizeToApps <- df %>% select(indexSizeBytes, nAppearances)
bloomSizeToApps <- df %>% select(bloomSizeBytes, nAppearances)
firstAppToAddrs <- df %>% select(firstAppearance, nAddresses)
addrsToApps <- df %>% select(nAddresses, nAppearances)
tsToApps <- df %>% select(firstTs, nAppearances)
blkToApps <- df %>% select(firstAppearance, nAppearances)

idxSizeToApps %>% plot()
bloomSizeToApps %>% plot()
firstAppToAddrs %>% plot()
addrsToApps %>% plot()
tsToApps %>% plot()
blkToApps %>% plot()
