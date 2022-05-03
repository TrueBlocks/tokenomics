library(httr)
library(jsonlite)

options(stringsAsFactors = FALSE)

url  <- "http://localhost:8080"
path <- "chunks?extract=stats"
raw.result <- GET(url = url, path = path)
raw.result
head(raw.result$content)
this.raw.content <- rawToChar(raw.result$content)
this.content <- fromJSON(this.raw.content)
