require(tidyverse)
require(scales)

#------------------------------------------------------------
df <- read_csv('./data/prices.csv')

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
fn <- "daily_price_history.png"

#------------------------------------------------------------
jpeg(paste("./images/", fn), width = 1200, height = 700)
plot
dev.off()
