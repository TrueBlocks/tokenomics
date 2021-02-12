require(tidyverse)
require(scales)

setwd("/Users/jrush/Development/tokenomics/explorations/errors/")
result <- system("./get_data.sh", TRUE, wait = TRUE)
tail(result)

df <- read_csv('counts.csv') %>%
  mutate(pctErrCurr = (currErrors / currCount) * 100) %>%
  mutate(pctErrTotal = (totErrors / totCount) * 100) %>%
  mutate(txPerBlock = totCount / blockNum) %>%
  mutate(errsPerBlock = totErrors / blockNum)
  
df <- df %>% filter(blockNum > 300000)

head(df)
tail(df)

sample  <- df %>% sample_frac(.2)
#sample <- df

#------------------------------------------------------------
chart_title <- "Errors as a Pct of Total Transactions"
x_vals <- sample$blockNum
x_label <- "Block Number"
y_vals <- sample$pctErrTotal
y_label <- "Pct Errors"
anno1.text <- "Source: Ethereum mainnet"
anno1.x.pct = .15
anno1.y.pct = .05
anno2.text <- "Produced for Tokenomics™ by TrueBlocks, LLC"
anno2.x.pct = .15
anno2.y.pct = .99
source(file="../common/chart_defaults.R")
#------------------------------------------------------------
errsPctTxs <- sample %>%
  ggplot(aes(x = blockNum, y = pctErrTotal, color = txPerBlock)) +
  geom_point() +
  geom_smooth() +
  labels + anno1 + anno2 +
  theme + xaxis + yaxis

chart_title <- "Pct Errors per Block"
y_vals <- sample$pctErrCurr
y_label <- "Error per Block"
source(file="../common/chart_defaults.R")
#------------------------------------------------------------
errsPctTxsPerBlock <- sample %>%
  ggplot(aes(x = blockNum, y = pctErrCurr, color = txPerBlock)) +
  geom_point() +
  geom_smooth() +
  labels + anno1 + anno2 +
  theme + xaxis + yaxis

errsPctTxs
#errsPctTxsPerBlock

#pec <- sample %>% select(blockNum, currErrors, currCount)
#pec
#pec %>% plot()

#tpb <- df %>% select(blockNum, txPerBlock)
#tpb %>% plot()
