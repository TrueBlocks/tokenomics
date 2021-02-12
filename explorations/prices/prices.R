require(tidyverse)
require(lubridate)
require(scales)

#------------------------------------------------------------
df <- read.csv("./store/prices.csv", sep=",", header=TRUE) %>%
  mutate(date = ymd_hms(str_replace(date, "T", " "))) %>%
  sample_frac(.1)

#------------------------------------------------------------
chart_title <- "Ether Price in USD (Daily)"
x_vals <- df$timestamp
y_vals <- df$close
source <- "Source: Poloniex, November 22, 2019"
x_label <- ""
y_label <- "USD"

#------------------------------------------------------------
source(file="chart_defaults.R")

#------------------------------------------------------------
plot <- df %>%
  ggplot(aes(x = timestamp, y = y_vals, cey.lab = 1)) +
  stat_smooth(method = "gam", formula = y ~ s(x, bs = "cs"), size = 1, span = 100) +
  geom_line() +
  labels +
  anno1 + anno2 +
  theme + 
  xaxis + yaxis
plot

#------------------------------------------------------------
fn <- "./images/daily_price_history.png"

#------------------------------------------------------------
jpeg(fn, width = 1200, height = 700)
plot
dev.off()
