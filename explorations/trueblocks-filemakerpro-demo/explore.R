# This file is in the public domain
require(tidyverse)

params <- list(
  address = "0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359",
  name = "EtherumTipJar"
)

params$filepath <- "data/output.csv"

data.set <- read_csv(params$filepath) %>%
  mutate(Date = as.POSIXct(Date, format="%m/%d/%Y %H:%M:%S")) %>%
  mutate(FunctionName = ifelse(is.na(FunctionName), "NA", FunctionName)) %>%
  mutate(isError = isError == 1) %>%
  return()


data.set %>%
  mutate(Type = ifelse(To == params$address, "In", ifelse(From == params$address, "From", "Other"))) %>%
  filter(Type %in% c("In", "Out")) %>%
  mutate(Date = as.Date(Date)) %>%
  mutate(EtherValue = ifelse(Type == "Out", -EtherValue, EtherValue)) %>%
  group_by(Type, Date) %>%
  summarize(val = sum(EtherValue)) %>%
  mutate(cumval = cumsum(val)) %>%
  ggplot(aes(x=Date, y=cumval, color=Type)) +
  geom_line() +
  labs(title="Ether In/Out", y="Cumulative Ether In/Out")

data.set %>%
  filter(To == params$address) %>%
  ggplot(aes(x=BlockNumber, fill=FunctionName)) +
  geom_histogram() +
  labs(title = paste0("Functions called on address ", params$address))


top10 <- data.set %>%
  filter(To == params$address) %>%
  mutate(FromName = ifelse(is.na(FromName), From, FromName)) %>%
  group_by(FromName) %>%
  summarize(count = n()) %>%
  top_n(10, count) %>%
  select(FromName) %>%
  unlist() %>%
  unname()

data.set %>%
  filter(To == params$address) %>%
  mutate(FromName = ifelse(is.na(FromName), From, FromName)) %>%
  filter(FromName %in% top10) %>%
  ggplot(aes(x=Date, y=FunctionName, color=FromName)) +
  geom_point() +
  facet_wrap(facets = 'FromName') +
  # scale_y_discrete(limits=rev(c('startAuction', 'startAuctions', 'startAuctionsAndBid', 'newBid', 'unsealBid', 'finalizeAuction', 'transfer', 'invalidateName'))) +
  theme(legend.position="none") +
  labs(title = paste0("Top 10 users function timeline"))


top10 <- data.set %>%
  filter(To == "0xecbc1cf6e45aada03cf557cfd20f85be9b29327d") %>%
  mutate(FromName = ifelse(is.na(FromName), From, FromName)) %>%
  group_by(FromName) %>%
  summarize(count = n()) %>%
  top_n(10, count) %>%
  select(FromName) %>%
  unlist() %>%
  unname()
top10 %>% View()
