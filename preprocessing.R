library(readr)
library(dplyr)
library(sqldf)
library(ggplot2)


#load data
setwd("/Users/jessymin/Documents/instacart_dataset/data")

department <- read_csv('departments.csv')
aisle <- read_csv('aisles.csv')
product <- read_csv('products.csv')
product <- product[,-1]
order <- read_csv('orders.csv')
order_products__prior <- read_csv('order_products__prior.csv')
order_products__train <- read_csv('order_products__train.csv')
order_products <- rbind(order_products__prior, order_products__train)


#Reshape data (as.factor) ---> later

setwd("/Users/jessymin/Documents/instacart_data_analysis")
