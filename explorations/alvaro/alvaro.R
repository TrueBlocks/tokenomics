# This file is in the public domain
library(tidyjson)
library(dplyr)   
library(httr)
library(jsonlight)

from_api <- GET('http://localhost:8080/names')

purch_json <- '[{"name": "bob", "purchases": [{"date": "2014/09/13","items": [{"name": "shoes", "price": 187},{"name": "belt", "price": 35}]}]},{"name": "susan", "purchases": [{"date": "2014/10/01","items": [{"name": "dress", "price": 58},{"name": "bag", "price": 118}]},{"date": "2015/01/03","items": [{"name": "shoes", "price": 115}]}]}]'  
p1 <- purch_json %>% gather_array
p1
p2 <- p1 %>% spread_values(person = jstring("name"))
p2
p3 <- p2 %>% enter_object("purchases")
p3
p4 <- p3 %>% gather_array
p4
p5 <- p4 %>% spread_values(purchase.date = jstring("date"))
p5
p6 <- p5 %>% enter_object("items")
p6
p7 <- p6 %>% gather_array
p7
p8 <- p7 %>% spread_values(item.name = jstring("name"), item.price = jnumber("price"))
p8
p9 <- p8 %>% select(person, purchase.date, item.name, item.price)
p9
