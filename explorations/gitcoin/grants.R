library(tidyverse)

tb_names <- function(term){
  cmd <- "names"
  url <- paste0("http://localhost:8080/", cmd, "?expand&terms=", term)
  url
  res <- GET(url)
  fromJSON(rawToChar(res$content))$data
}
core <- tb_names("GitCoin%20Grants:Core")
#core

grants <- tb_names("GitCoin%20Grants:Grant")
#grants
