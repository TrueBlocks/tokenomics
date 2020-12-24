# This file is in the public domain
library(tidyjson)
library(dplyr)   
library(httr)
library(ggplot2)
library(ggrepel)

par(las=2)

file <- "/Users/jrush/Development/trueblocks-analysis/turbo-geth-syncing/sorted.csv"
df <- read.csv(file, TRUE, ",", "\"", ".", TRUE, "#", stringsAsFactors = FALSE)
df <- df %>% filter(row_number() %% 10 == 1)
df <- df %>% mutate(bytes_br = as.numeric(stat_branch_bytes))
df <- df %>% mutate(bytes_lf = as.numeric(stat_leaf_bytes))
df <- df %>% mutate(bytes_ov = as.numeric(stat_overflow_bytes))
df <- df %>% mutate(bytes = bytes_br + bytes_lf + bytes_ov)
df <- df %>% mutate(gb = bytes / 1024 / 1024 / 1024)

#graphed <- df %>% filter(
  #(
    #(longname == 'AccountHistoryBucket')
    #|
      #  (longname == 'BlockBodyPrefix')
    #|
      #  (longname == 'Log')
    #|
      #  (longname == 'LogTopicIndex')
    #|
      #  (longname == 'PlainAccountChangeSetBucket')
    #|
      #  (longname == 'PlainStorageChangeSetBucket')
    #|
      #  (longname == 'Senders')
    #|
      #  (longname == 'StorageHistoryBucket')
    #|
      #  (longname == 'TxLookupPrefix')
    #)
  #)
#df <- df %>% filter(df$gb <= 1)

graphed <- df %>% mutate(observation = 1:n())
tail(graphed, 42)
marker = length(graphed$observation) - 41
graphed <- graphed %>% mutate(label = ifelse(gb > 10 & graphed$observation > marker, graphed$longname, NA))
tail(graphed, 42)

thePlot <- ggplot(graphed, aes(x = observation, y = gb, group=longname, color=longname))+
  geom_bar(stat="identity", colour=c("white"), width=1, position="dodge")+
  theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5), legend.position = "none")+
  labs(title="Size of tables during sync (bytes, large tables (>1GB), sampled every 15 minutes)", size="20pt", y="Size in GB")+
  geom_line(stat="identity", linetype=3, size=.8)+
  geom_label_repel(aes(label = label), nudge_x = 1, na.rm = TRUE)

thePlot

#png("images/overall.png", width = 1280, height = 960)
#thePlot
#dev.off()

