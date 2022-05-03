library(lubridate)
library(readr)
library(tidyverse)
library(ggthemes)

setwd("~/Development/tokenomics/explorations/difficulty/")
data <- read_csv("store/difficulty.csv")
data <- data[-nrow(data), ]
latest <- 1650931200 # max(data$timestamp)
as_datetime(latest)

n_days <- 7
period <- "week"
adverb <- "Weekly"

#n_days <- 1
#period <- "day"
#adverb <- "Daily"

title <- paste("Ethereum", adverb, "Block Production")
axis <- paste("Number of blocks per", period)

#####################################################################
# EDIT THIS
lab <- " at block 14,679,531 - 2022-04-29 13:45:38 UTC "
latestDate = "2022-04-28"
#####################################################################

## Make a x axis range
result <- data.frame(date = seq(as_datetime("2015-09-01"), as_datetime("2022-09-01"), by = period), num_blocks = NA)
## Get stats for every value in range
for (idx in 1:nrow(result)) {
    date <- result$date[idx]
    result$num_blocks[idx] <- diff(range(data$blocknumber[data$timestamp >= as.numeric(date - days(n_days)) & data$timestamp <= as.numeric(date)])) # nolint
    message(paste0(idx, "/", nrow(result)))
}
# plot(result,type="l",pch=19) # nolint
result
max(result$date)

secs <- ymd("2022-09-01")
jun15 <- ymd("2022-06-15")

result2 <- result %>%
    as_tibble() %>%
    mutate(date = as_date(date)) %>%
    filter(is.finite(num_blocks)) %>%
    filter(date < latestDate)
tail(result2)

hard_fork_ts <- c(
    1508131331,
    1551383524,
    1575764709,
    1577953849,
    1618481223,
    1628166822,
    1639022046
)

hard_forks <- as_date(as_datetime(hard_fork_ts))

per_31_ts <- c(
    1485904756,
    1533578575,
    1562446275,
    1616567660,
    1616567660,
    1639440039
)
per_31s <- as_date(as_datetime(per_31_ts))

time_blocks <- c(
    (n_days * 24 * 60 * 60) / 14,
    (n_days * 24 * 60 * 60) / 16,
    (n_days * 24 * 60 * 60) / 18,
    (n_days * 24 * 60 * 60) / 20,
    (n_days * 24 * 60 * 60) / 22,
    (n_days * 24 * 60 * 60) / 24,
    (n_days * 24 * 60 * 60) / 26,
    (n_days * 24 * 60 * 60) / 28,
    (n_days * 24 * 60 * 60) / 30
)

max <- result2$num_blocks %>% max()

anno1 <- ymd("2015-12-15")
anno2 <- ymd("2021-10-15")

write.table(result2, file = "data.csv", sep = "\t", row.names = F)

ggplot(result2, aes(x = date, y = num_blocks)) +
    geom_line(colour = "darkblue") +
    geom_vline(xintercept = hard_forks, linetype = "dashed", colour = "grey60") +
    geom_vline(xintercept = jun15, linetype = "solid", colour = "red") +
    geom_vline(xintercept = per_31s, linetype = "dashed", colour = "pink") +
    geom_hline(yintercept = time_blocks, linetype = "dashed", colour = "grey60") +
    annotate("text", x = secs, y = time_blocks[1] + 350, label = "14s") +
    annotate("text", x = secs, y = time_blocks[3] + 350, label = "18s") +
    annotate("text", x = secs, y = time_blocks[5] + 350, label = "22s") +
    annotate("text", x = secs, y = time_blocks[7] + 350, label = "26s") +
    annotate("text", x = anno1, y = max * .2, label = "produced from on-chain data\nby TrueBlocks and OmniAnalytics", size = 3, fontface = "italic", hjust = 0) +
    geom_label(aes(x = anno2, y = max * .2, fontface = "italic", label = lab), fill = "#fafafa") +
    scale_x_date(breaks = seq.Date(ymd("2015-12-01"), ymd("2022-09-01"), by = "6 months"), date_labels = "%b %y", limits = c(ymd("2015-12-01", "2022-09-01"))) +
    scale_y_continuous(breaks = seq(0, max, by = 5000), labels = scales::comma) +
    labs(y = axis, x = "", title = title, subtitle = "From September 2015 until the Present") +
    theme_classic() +
    theme(panel.grid = element_blank())
