# This file is in the public domain
library(tidyjson)
library(dplyr)   
library(httr)
library(ggplot2)

file <- "/Users/jrush/Development/trueblocks-analysis/turbo-geth-syncing/bytes.csv"
df <- read.csv(file, TRUE, ",", "\"", ".", TRUE, "#", stringsAsFactors = FALSE)
head(df)
df <- df %>% filter(longname == "BlockBodyPrefix")
df <- df %>% filter(type == "overflow")
head(df)
df <- df %>% mutate(observation = 1:n())
head(df)
df <- df %>% select(observation,id,longname,bytes,type)
head(df)
#df <- df %>% filter(row_number() %% 3 == 1)
df <- df %>% mutate(bytes = as.numeric(bytes))
df <- df %>% mutate(gb = as.numeric(bytes) / 1024 / 1024 / 1024)
head(df)

#df <- df %>% filter(df$gb <= 1)

par(las=2)
ggplot(df, aes(x = observation, y=gb, fill=type))+
  geom_bar(stat="identity", colour=c("snow3"), position="stack")

+
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))+
  scale_colour_gradient(low = "#132B43", high = "#56B1F7",
                        space = "Lab", na.value = "grey50",
                        aesthetics = "colour")+
  labs(title="Size of tables during sync (bytes, large tables (>1GB), sampled every 15 minutes)", size="20pt", y="Size in GB")+
  geom_line(stat="identity", linetype=3)
