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

#       0	1438269960	2015-07-30 15:26:00 UTC
#  778482	1451606392	2015-12-31 23:59:52 UTC
# 1801798	1467331197	2016-06-30 23:59:57 UTC
# 2912406	1483228771	2016-12-31 23:59:31 UTC
# 3955158	1498867196	2017-06-30 23:59:56 UTC
# 4832685	1514764787	2017-12-31 23:59:47 UTC
# 5883489	1530403186	2018-06-30 23:59:46 UTC
# 6988614	1546300782	2018-12-31 23:59:42 UTC
# 8062292	1561939196	2019-06-30 23:59:56 UTC
# 9193265	1577836785	2019-12-31 23:59:45 UTC
#10370273	1593561580	2020-06-30 23:59:40 UTC
#------------------------------------------------------------
xaxis <-
  scale_x_continuous(
    breaks = c(1451606392, 1467331197, 1483228771, 1498867196,
               1514764787, 1530403186, 1546300782, 1561939196,
               1577836785, 1593561580, 1609372788, 1625097583),
    labels = c("Jan 16", "Jul 16", "Jan 17", "Jul 17",
               "Jan 18", "Jul 18", "Jan 19", "Jul 19",
               "Jan 20", "Jul 20", "Jan 21", "Jul 21"),
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

