require(tidyverse)
require(scales)

#------------------------------------------------------------
theme <-
  theme(
    plot.background = element_rect(fill = "lightgray"),
    panel.background = element_rect(fill = "snow1"),
    panel.border = element_rect(linetype = "dashed", fill = NA),
    title = element_text(size = 18, face = "bold"),
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(angle = 90, vjust = 1, size = 12),
    axis.ticks.y = element_blank(),
    legend.text = element_text(size = 14)
  );

#------------------------------------------------------------
xaxis <-
  scale_x_continuous(
    breaks = c(1451606400, 1467331200, 1483228800, 1498867200,
               1514764800, 1530403200, 1546300800, 1561939200, 1574380800),
    labels = c("Jan 16", "Jul 16", "Jan 17", "Jul 17",
               "Jan 18", "Jul 18", "Jan 19", "Jul 19", "Nov 19"),
  )

#------------------------------------------------------------
yaxis <-
  scale_y_continuous( label = comma )

#------------------------------------------------------------
labels <-
  labs(
    x = x_label,
    y = y_label,
    title = chart_title
  )

#------------------------------------------------------------
anno1 <-
  annotate("text",
           x = ((floor(max(x_vals) / 10000000) * 10000000) - 10000000), y = min(y_vals),
           label= source,
           fontface = "bold.italic", size = 5, color = "gray70"
  )

#------------------------------------------------------------
anno2 <-
  annotate("text",
           x = min(x_vals) + 22500000, y = ceiling(max(y_vals) / 500) * 500,
           label= "Produced for the Tokenomics™ website by TrueBlocks, LLC",
           fontface = "bold.italic", size = 5, color = "gray70"
  )

