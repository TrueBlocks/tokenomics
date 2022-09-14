# Data
nosis <- read.csv("gnosis-step-50000.csv")
nosis <- subset(nosis, select = -c(finalized))

mn <- read.csv("mainnet-step-50000.csv")
mn <- subset(mn, select = -c(finalized))

sep <- read.csv("sepolia-step-5000.csv")
sep <- subset(sep, select = -c(finalized))



# Seconds per Block

chaintime.mn <- (mn$timestamp[nrow(mn)]-mn$timestamp[1])/mn$blockNumber[nrow(mn)]

chaintime.sep <- (sep$timestamp[nrow(sep)]-sep$timestamp[1])/sep$blockNumber[nrow(sep)]

chaintime.nosis <- (nosis$timestamp[nrow(nosis)]-nosis$timestamp[1])/nosis$blockNumber[nrow(nosis)]
# Blocks per 12 hours
blocksper12.mn <- 43200/chaintime.mn
print(blocksper12.mn)
blocksper12.sep <- 43200/chaintime.sep
print(blocksper12.sep)
blocksper12.nosis <- 43200/chaintime.nosis
print(blocksper12.nosis)
# Transactions per Block
trcnt.mn <- sum(mn$transactionsCnt)/mn$blockNumber[nrow(mn)]

trcnt.sep <- sum(sep$transactionsCnt)/sep$blockNumber[nrow(sep)]

trcnt.nosis <- sum(nosis$transactionsCnt)/nosis$blockNumber[nrow(nosis)]
# Transactions per 12 Hours
trcnt.mn*blocksper12.mn

trcnt.sep*blocksper12.sep

trcnt.nosis*blocksper12.nosis


# Year by Timestamp
mn$year <- as.factor(ifelse(mn$timestamp < 1451606400, '2015',
                            ifelse(mn$timestamp < 1483228800, '2016',
                                   ifelse(mn$timestamp < 1514764800, '2017',
                                          ifelse(mn$timestamp < 1546300800, '2018',
                                                 ifelse(mn$timestamp < 1577836800, '2019',
                                                        ifelse(mn$timestamp < 1609459200, '2020',
                                                               ifelse(mn$timestamp < 1640995200, '2021',
                                                                      ifelse(mn$timestamp < 1840995200, '2022')))))))))

sep$year <- as.factor(ifelse(sep$timestamp < 1451606400, '2015',
                             ifelse(sep$timestamp < 1483228800, '2016',
                                    ifelse(sep$timestamp < 1514764800, '2017',
                                           ifelse(sep$timestamp < 1546300800, '2018',
                                                  ifelse(sep$timestamp < 1577836800, '2019',
                                                         ifelse(sep$timestamp < 1609459200, '2020',
                                                                ifelse(sep$timestamp < 1640995200, '2021',
                                                                       ifelse(sep$timestamp < 1840995200, '2022')))))))))
nosis$year <- as.factor(ifelse(nosis$timestamp < 1451606400, '2015',
                               ifelse(nosis$timestamp < 1483228800, '2016',
                                      ifelse(nosis$timestamp < 1514764800, '2017',
                                             ifelse(nosis$timestamp < 1546300800, '2018',
                                                    ifelse(nosis$timestamp < 1577836800, '2019',
                                                           ifelse(nosis$timestamp < 1609459200, '2020',
                                                                  ifelse(nosis$timestamp < 1640995200, '2021',
                                                                         ifelse(nosis$timestamp < 1840995200, '2022')))))))))

# Graphing Results
plot(mn$timestamp, mn$transactionsCnt, col = factor(mn$year))

legend("topleft",
       legend = levels(factor(mn$year)),
       title = "Main Net Transactions over Time",
       pch = 19,
       col = factor(levels(factor(mn$year))))

plot(sep$timestamp, sep$transactionsCnt, col = factor(sep$year))

legend("topleft",
       legend = levels(factor(sep$year)),
       title = "Sepolia Transactions over Time",
       pch = 19,
       col = factor(levels(factor(sep$year))))

plot(nosis$timestamp, nosis$transactionsCnt, col = factor(nosis$year))

legend("topleft",
       legend = levels(factor(nosis$year)),
       title = "Gnosis Transactions over Time",
       pch = 17,
       col = factor(levels(factor(nosis$year))))

#save a jpeg
#jpeg(file="saving_plot1.jpeg")



# Data
main <- read.csv("mainnet.csv")
N = nrow(main)
main$X <- c(1:N)

sepol <- read.csv("sepolia.csv")
N = nrow(sepol)
sepol$X <- c(1:N)

gnosis <- read.csv("gnosis.csv")
N = nrow(gnosis)
gnosis$X <- c(1:N)

# Appearances per 12 hours

x <- gnosis$appsPerBlock*blocksper12.nosis
y <- main$appsPerBlock*blocksper12.mn
z <- sepol$appsPerBlock*blocksper12.sep

barplot(x, title(main = "Gnosis Appearances every 12 Hours"), sub = "in blocks of ~ 10,000")
barplot(y, title(main = "Main Net Appearances every 12 Hours"), sub = "rounded by block groupings")
barplot(z, title(main = "Sepolia Appearances every 12 Hours"), sub = "rounded by block groupings")
