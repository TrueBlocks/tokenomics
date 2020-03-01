import("purrr")
import("jsonlite")
export("get_bn", "get_ts", "get_date")

base_dir = "/Users/jrush/Development/tokenomics/explorations/"
filename <- paste(base_dir, "common/named_blocks.json", sep = "")
named_blocks <- fromJSON(filename)
typeof(named_blocks)
filename <- NULL

named_blocks.bn <- sapply(unique(named_blocks$name), function(x) { named_blocks[named_blocks$name == x, 1] }, simplify = FALSE)
named_blocks.ts <- sapply(unique(named_blocks$name), function(x) { named_blocks[named_blocks$name == x, 2] }, simplify = FALSE)
named_blocks.date <- sapply(unique(named_blocks$name), function(x) { named_blocks[named_blocks$name == x, 4] }, simplify = FALSE)

get_bn <- function(name) {
  ## returns a named block's blockNumber
  return (named_blocks.bn[[name]])
}
get_ts <- function(name) {
  ## returns a named block's timestamp
  return (named_blocks.ts[[name]])
}
get_date <- function(name) {
  ## returns a named block's date
  return (named_blocks.date[[name]])
}
