library(lubridate)
library(readr)
library(tidyverse)

data <- read_csv("store/difficulty.csv")
data <- data[-nrow(data),]
latest <- max(data$timestamp)
as_datetime(latest)

## Make a x axis range
result <- data.frame(date = seq(as_datetime("2015-09-01"),as_datetime("2022-09-01"), by="week"),num_blocks = NA)
## Get stats for every value in range
for(idx in 1:nrow(result))
{
    result$num_blocks[idx] <- diff(range(data$blocknumber[data$timestamp >= as.numeric(result$date[idx]-days(7)) & data$timestamp <= as.numeric(result$date[idx])]))
    message(paste0(idx,"/",nrow(result)))
}
# plot(result,type="l",pch=19)

#result

latest <- ymd("2022-02-25")
secs <- ymd("2022-09-01")
jun15 <- ymd("2022-06-15")
anno <- ymd("2015-12-15")

result2 <- result %>%
    as_tibble() %>%
    mutate(date = as_date(date)) %>%
    filter(is.finite(num_blocks)) %>%
    filter(date <= latest)
    
hard_fork_ts <- c(1508131331, 1551383524, 1575764709, 1577953849, 1618481223, 1628166822, 1639022046)
hard_forks <- as_date(as_datetime(hard_fork_ts))

time_blocks <- c((7*24*60*60) / 14,
                 (7*24*60*60) / 16,
                 (7*24*60*60) / 18,
                 (7*24*60*60) / 20,
                 (7*24*60*60) / 22,
                 (7*24*60*60) / 24,
                 (7*24*60*60) / 26,
                 (7*24*60*60) / 28,
                 (7*24*60*60) / 30)

library(ggthemes)

ggplot(result2, aes(x = date, y = num_blocks)) +
    geom_line(colour = "darkblue") +
    geom_vline(xintercept = hard_forks, linetype = "dashed", colour = "grey60") +
    geom_vline(xintercept = jun15, linetype = "solid", colour = "pink") +
    geom_hline(yintercept = time_blocks, linetype = "dashed", colour = "grey60") +
    annotate("text", x = secs, y = time_blocks[1]+350, label = "14s") +
    annotate("text", x = secs, y = time_blocks[3]+350, label = "18s") +
    annotate("text", x = secs, y = time_blocks[5]+350, label = "22s") +
    annotate("text", x = secs, y = time_blocks[7]+350, label = "26s") +
    annotate("text", x = anno, y = 20900, label = "produced from on-chain data\nby TrueBlocks and OmniAnalytics", size = 3, fontface = "italic", hjust = 0) +
    scale_x_date(breaks = seq.Date(ymd("2015-12-01"), ymd("2022-09-01"), by = "6 months"), date_labels = "%b %y", limits = c(ymd("2015-12-01", "2022-09-01"))) +
    scale_y_continuous(breaks = seq(0, 150000, by = 5000), labels = scales::comma) +
    labs(y = "Number of Blocks per Week",x = "",title = "Ethereum Weekly Block Production",subtitle = "From September 2015 until the Present") +
    theme_classic() +
    theme(panel.grid = element_blank())

