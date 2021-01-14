# This file is in the public domain
library(tidyjson)
library(dplyr)   
library(httr)
library(ggplot2)
library(ggrepel)
library(jsonlite)

par(las=2)

#file <- "/Users/jrush/Development/trueblocks-analysis/deposit-contract/deposit_contact.csv"
#df <- read.csv(file, TRUE, ",", "\"", ".", TRUE, "#", stringsAsFactors = FALSE)
file <- url("http://localhost:8080/export?addrs=0x00000000219ab540356cBB839Cbe05303d7705Fa")
df <- fromJSON(file)
#View(df)
df <- df$data
graphed <- df %>%
  mutate(observation = 1:n())
graphed <- graphed %>% select(date, ether)
graphed <- graphed %>% filter(date > "2020-10-31")
head(graphed)
day <- as.numeric(substr(graphed$date, 9, 10))
day
hour <- floor(as.numeric(substr(graphed$date, 12, 13))/12)
hour
graphed <- graphed %>%
  mutate(date2 = ISOdate(2020, 11, day, hour))

graphed$date2

aggy <- aggregate(graphed["ether"], by=graphed["date2"], sum)

ggplot(aggy, aes(x = date2, y = ether))+
  geom_bar(stat="identity", position="dodge")+
  geom_smooth(stat="identity")+
  labs(title="Daily Deposits", size="20pt", y="Hourly Ether Deposits")
