require(tidyverse)
require(scales)

#------------------------------------------------------------
df <- read_csv('./data/hash-rate-daily.csv')

#------------------------------------------------------------
chart_title <- "Daily Average GigHashes per Second"
x_vals <- df$timestamp
y_vals <- df$avg_gh_per_sec
source <- "Source: Etherscan, November 22, 2019"
x_label <- ""
y_label <- "Avg GH/second"

#------------------------------------------------------------
source(file="chart_defaults.R")

#------------------------------------------------------------
plot <- df %>%
  ggplot(aes(x = timestamp, y = avg_gh_per_sec, cey.lab = 1)) +
  stat_smooth(method = "gam", formula = y ~ s(x, bs = "cs"), size = 1, span = 100) +
  geom_line() +
  geom_vline(xintercept = named.BYZANTIUM.ts, color = "lightgrey") +
  geom_vline(xintercept = named.CONSTANTINOPLE.ts, color = "lightgrey") +
  labels +
  anno1 + anno2 +
  theme + 
  xaxis + yaxis
plot

#------------------------------------------------------------
fn <- "daily_avg_gh_per_sec.png"

#------------------------------------------------------------
jpeg(paste("./images/", fn), width = 1200, height = 700)
plot
dev.off()
