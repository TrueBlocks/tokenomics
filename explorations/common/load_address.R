require(tidyverse)
require(scales)

# assumes both the `address` and the `name` values contain valid data
url <- paste0("http://localhost:8080/list?addrs=", address)
ret <- url %>% fromJSON()
ret <- ret$data %>% as_tibble()
ret <- ret %>% mutate(address = name)
