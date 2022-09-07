library(httr)
library(jsonlite)
require(tidyverse)
require(scales)
library(ggplot2)

currency <- "ETH"
usd <- TRUE

max <- 3000
address <- "0xf503017d7baf7fbc0fff7492b751025c6a78179b"
server <- "http://localhost:8080/export?"
options <- paste("&statements&cache&ether&maxRecords=", toString(max), sep = "")
format <- "&fmt=json"
url <- paste(server, "addrs=", address, options, format, sep = "")
url

raw_data <- fromJSON(rawToChar(GET(url)$content))$data
names(raw_data)

raw_data <- raw_data[order(raw_data$assetSymbol, raw_data$blockNumber, raw_data$transactionIndex), ]
if (!usd) {
  raw_data <- raw_data %>% mutate(spotPrice = 1.0)
}
names(raw_data)

data <- raw_data %>%
  # mutate(spotPrice = ifelse(usd,spotPrice,1.0)) %>%
  mutate(date = as.POSIXct(timestamp, origin = "1970-01-01")) %>%
  mutate(
    totalIn =
      ifelse(is.na(as.numeric(totalIn)), 0, as.numeric(totalIn))
  ) %>%
  mutate(totalInExt = totalIn * spotPrice) %>%
  mutate(
    totalOut =
      ifelse(is.na(as.numeric(totalOut)), 0, as.numeric(totalOut))
  ) %>%
  mutate(totalOutExt = totalOut * spotPrice) %>%
  mutate(
    totalOutLessGas =
      ifelse(is.na(as.numeric(totalOutLessGas)), 0, as.numeric(totalOutLessGas))
  ) %>%
  mutate(totalOutLessGas = totalOutLessGas) %>%
  mutate(totalOutLessGasExt = totalOutLessGas * spotPrice) %>%
  mutate(
    gasCostOut =
      ifelse(is.na(as.numeric(gasCostOut)), 0, as.numeric(gasCostOut))
  ) %>%
  mutate(gasCostOut = gasCostOut) %>%
  mutate(gasCostOutExt = gasCostOut * spotPrice) %>%
  mutate(
    amountNet =
      ifelse(is.na(as.numeric(amountNet)), 0, as.numeric(amountNet))
  ) %>%
  mutate(amountNetExt = amountNet * spotPrice) %>%
  mutate(
    begBal =
      ifelse(is.na(as.numeric(begBal)), 0, as.numeric(begBal))
  ) %>%
  mutate(begBalExt = begBal * spotPrice) %>%
  mutate(
    endBal =
      ifelse(is.na(as.numeric(endBal)), 0, as.numeric(endBal))
  ) %>%
  mutate(endBalExt = endBal * spotPrice) %>%
  mutate(recon = totalIn - totalOutLessGas) %>%
  filter(amountNet != 0.0) %>%
  select(blockNumber, transactionIndex, timestamp, date, assetAddr, assetSymbol, begBal, totalIn, gasCostOut, totalOutLessGas, totalOut, amountNet, endBal, spotPrice, priceSource, begBalExt, totalInExt, gasCostOutExt, totalOutLessGasExt, totalOutExt, amountNetExt, endBalExt)

names(data)
str(data)
head(data)
filtered <- data
if (currency != "") {
  if (TRUE) {
    filtered <- data %>% filter(assetSymbol == currency)
  } else {
    filtered <- data %>% filter(assetSymbol != currency)
  }
}


# priced %>%
#  filter(asset != "ETH" & asset != "DAI") %>%
#  ggplot(aes(x=asset)) +
#    geom_bar() +
#    geom_density(alpha=.2, fill="#FF6666")
#    theme(axis.text.x = element_text(angle = 90))
#
#
#
# prices$asset %>%
#  ggplot(priced$asset, geom="bar")
#
#    filter(Entity %in% countries) %>%
#  ggplot(aes(Entity,`Rice (tonnes per hectare)`)) +
#  geom_boxplot() +
#  geom_jitter(width=0.15) +
#  theme(axis.text.x = element_text(angle = 90))

# qplot(priced$asset, geom="bar")

# long_tail <- priced %>% filter(asset != "ETH" & asset != "DAI")
# qplot(long_tail$asset, geom="bar")

priced <- filtered %>%
  mutate(bn = blockNumber) %>%
  mutate(txid = transactionIndex) %>%
  mutate(prev = lag(endBalExt)) %>%
  mutate(beg = begBalExt) %>%
  mutate(inflow = totalInExt) %>%
  mutate(outflow = totalOutLessGasExt) %>%
  mutate(gas = gasCostOutExt) %>%
  mutate(totOut = totalOutExt) %>%
  mutate(net = amountNetExt) %>%
  mutate(end = endBalExt) %>%
  mutate(asset = assetSymbol) %>%
  mutate(spot = spotPrice) %>%
  mutate(source = priceSource) %>%
  select(date, bn, txid, asset, spot, source, prev, beg, inflow, outflow, gas, totOut, net, end)

priced %>%
  filter(end > 5000) %>%
  ggplot(aes(x = date, y = end, fill = asset)) +
  geom_area()

# priced %>%
#  filter(end < 500000) %>%
#  ggplot(aes(x=date)) + geom_line(aes(y=end)) + geom_line(aes(y=beg, col=asset))

# ggplot(priced) +
#  geom_line(aes(x=date, ,y=end, color="blue")) +
#  stat_smooth(aes(x=date,y=end), method = lm, formula = y ~ poly(x, 10), se = FALSE)

# tail(priced, 20)

usd <- !usd
queried <- queried + 1
