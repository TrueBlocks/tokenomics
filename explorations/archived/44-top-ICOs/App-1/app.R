# This file is in the public domain
require(tidyverse)
require(jsonlite)
require(scales)
require(shiny)

data <- read_json(path = paste0('./jsondata/00_newbium-0x814964b1bceaf24e26296d031eadf134a2ca4105.json'),
                  simplifyVector=T,
                  simplifyDataFrame=T) %>%
  jsonlite::flatten() %>%
  as_data_frame() %>%
  mutate(fn.name = map_chr(articulatedTx, 'name', .default = NA))

in.out <- data %>%
  filter(fn.name == 'transfer', !isError) %>%
  mutate(transfer.values = map(articulatedTx, list('inputs',1, 'value'), .default = NA)) %>%
  mutate(transfer.to = map_chr(transfer.values, 1)) %>%
  mutate(transfer.amount = map_chr(transfer.values, 2) %>% as.integer()) %>%
  select(timestamp, from, transfer.to, transfer.amount)

in.out.cum <- in.out %>% 
  gather(key = 'address.type', value = 'address', 2:3) %>%
  mutate(transfer.amount = ifelse(address.type == 'from', -transfer.amount, transfer.amount)) %>%
  group_by(address, timestamp) %>%
  summarize(transfer.amount = sum(transfer.amount)) %>%
  mutate(cumBalance = cumsum(transfer.amount)) %>%
  ungroup()

timestamps <- in.out.cum %>% distinct(timestamp)
addresses <- in.out.cum %>% distinct(address)
address.timestamp <- crossing(addresses, timestamps) %>% arrange(address, timestamp)

addInitialSupplyBalance = function(data) {
  data %>%
    rbind(data.frame(
      address = '0xc9d7fec9889690bbff0a0df758d13e5a55dd7822', 
      address.type = 'transfer.to',
      timestamp = 1499459125,
      transfer.amount = 49000000
    )) %>%
    return()
}

in.out.cum.with.zeroes <- in.out %>%
  gather(key = 'address.type', value = 'address', 2:3) %>%
  addInitialSupplyBalance() %>%
  mutate(transfer.amount = ifelse(address.type == 'from', -transfer.amount, transfer.amount)) %>%
  group_by(address, timestamp) %>%
  summarize(transfer.amount = sum(transfer.amount)) %>%
  full_join(address.timestamp) %>%
  arrange(address, timestamp) %>%
  mutate(transfer.amount = ifelse(is.na(transfer.amount),0,transfer.amount)) %>%
  group_by(address, timestamp) %>%
  summarize(transfer.amount = sum(transfer.amount)) %>%
  mutate(cumBalance = cumsum(transfer.amount)) %>%
  ungroup()

top.10 <- in.out.cum.with.zeroes %>%
  group_by(address) %>%
  top_n(1, cumBalance) %>%
  distinct(address, .keep_all = T) %>%
  ungroup() %>%
  top_n(10, cumBalance) %>%
  arrange(desc(cumBalance)) %>%
  select(address)

# Define UI for app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Newbium token ownership over time"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      selectizeInput(inputId = "chart.type",
                     label="Chart Type:",
                     choices=c("Area", "Line")),
      
      checkboxGroupInput("addresses.to.show", "Addresses in top 10 to show:",
                         c(top.10$address, 'other'), selected=c(top.10$address, 'other')),
      
      # selectizeInput(inputId ="dropdown",
      #                label="Address:",
      #                choices=jsonfiles),
      
      dateRangeInput(inputId = "date.range",
                     label = "Date range:",
                     start = (min(timestamps) %>% as.POSIXct(origin='1970-01-01'))-86400,
                     end = (max(timestamps) %>% as.POSIXct(origin='1970-01-01'))+86400,
                     min = (min(timestamps) %>% as.POSIXct(origin='1970-01-01'))-86400,
                     #max = (max(timestamps) %>% as.POSIXct(origin='1970-01-01'))+86400,
                     format = "yyyy-mm-dd",
                     startview = "year")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot", height = '600px')
      #textOutput("testing")
      
      
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  output$testing <- renderText({
    paste(input$date.range)
  })
  
  output$distPlot <- renderPlot({
    
    do.plot <- function(newbium.data) {
      if(input$chart.type == 'Line') {
        plot <- newbium.data %>%
        ggplot(aes(x = date, y = cumBalance, color=address)) +
        scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
        ylab("Amount of Newbium Held") +
        geom_line()
    } else if(input$chart.type == 'Area') {
      plot <- newbium.data %>%
      ggplot(aes(x = date, y = cumBalance, fill=address)) +
      ylab("Proportion of Newbium Held to Total Supply)") +
      geom_area(position='fill')
    }
      plot +
        theme(text = element_text(size=16)) +
        xlab("Datetime") +
        scale_x_datetime(labels = date_format("%Y-%m-%d %H:%M")) %>%
      return()
    }
    
    in.out.cum.with.zeroes %>%
      mutate(address = ifelse(address %in% top.10$address, address, 'other')) %>%
      filter(address %in% c(input$addresses.to.show)) %>%
      group_by(address, timestamp) %>%
      arrange(address, timestamp) %>%
      summarize(cumBalance = sum(cumBalance)) %>%
      mutate(date = as.POSIXct(timestamp, origin='1970-01-01')) %>%
      filter(date >= as.POSIXct(input$date.range[1]), date <= as.POSIXct(input$date.range[2])) %>%
      do.plot()

  }, execOnResize = TRUE)
  
}

shinyApp(ui = ui, server = server)
