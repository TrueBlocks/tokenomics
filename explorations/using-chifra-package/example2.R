# This file is in the public domain
require("tidyverse")
require("jsonlite")

## select an address!
tip_jar <- "0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359"
address <- tip_jar

## this is how we get json and turn it into a tibble.
url <- paste0("http://localhost:8080/export?addrs=", address)
url
json_data <- url %>%
  fromJSON()

d <- json_data$data

test.data <- d %>%
  as_tibble()

## take a look at the data.
# test.data %>% View()

## let's massage the data, getting eth values.
test.data <- test.data %>%
  mutate(ether.val = value / 10^18)

## let's do a rudimentary chart showing value transferred for this address.
test.data %>%
  mutate(status = ifelse(from == address, "from", ifelse(to == address, "to", "other"))) %>%
  ggplot(aes(x = ether.val, fill = status)) +
  geom_histogram() +
  labs(caption = paste("This chart shows that address ", address, " was on the receiving end of a number of tx,",
    " but did not send any. You can also see the trace volume in blue, although it's not the most helpful ",
    " representation",
    sep = "\n"
  ))
