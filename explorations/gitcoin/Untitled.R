library(tidyverse)
library(httr)
library(jsonlite)

res = GET("http://localhost:8080/export?addrs=0xf503017d7baf7fbc0fff7492b751025c6a78179b&max_records=1000000")
res

df = fromJSON(rawToChar(res$content))$data %>%
        mutate(bin = floor(blockNumber / 100) * 100) %>%
        summarize(bin)
names(df)
df

ggplot(data = df, mapping = aes(x=bin)) + 
  geom_histogram(aes(y=..density..),fill="bisque",color="white",alpha=0.7) + 
  geom_density() +
  geom_rug() +
  labs(x='block') +
  theme_minimal() +
  facet_grid()
