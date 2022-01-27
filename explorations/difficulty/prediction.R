require(tidyverse)
require(scales)

df <- read_csv('store/estimated_2021_10_08.csv')
head(df)
df
x <- df$timestamp; y <- df$blocknumber # create some data
head(x)
head(y)
par(pch=22, col="red") # plotting symbol and color
#par(mfrow=c(2,4)) # all plots on one page
opts = c("s") # p","l","o","b","c","s","S","h")
for(i in 1:length(opts)){
  # heading = paste("type=",opts[i])
  plot(x, y)
  lines(x, y)
}

library(ggplot2)
# Basic line plot with points
ggplot(data=df, aes(x=timestamp, y=blocknumber)) +
  geom_line()+
  geom_point()

# Change the line type
#ggplot(data=df, aes(x=dose, y=len, group=1)) +
#  geom_line(linetype = "dashed")+
#  geom_point()
# Change the color
#ggplot(data=df, aes(x=dose, y=len, group=1)) +
#  geom_line(color="red")+
#  geom_point()