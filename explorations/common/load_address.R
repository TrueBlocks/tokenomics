require(tidyverse)
require(scales)

#' A function
#'
#' @param address An Ethereum address
#' @param name A name to assign to that address
#'
#' @return The dataframe containing all the appearances <blockNumber, transactionIndex> for the given address
#' @importFrom dplyr mutate
#' @importFrom rlang enquo
#' @importFrom rlang quo_name
#' @importFrom rlang :=
#' @export
get_address <- function(address, name) {
    url <- paste0("http://localhost:8080/list?addrs=", address)
    ret <- url %>% fromJSON()
    ret <- ret$data %>% as_tibble()
    ret <- ret %>% mutate(address = name)
    return ret
}
