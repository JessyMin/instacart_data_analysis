# Load packages
library(readr)
library(dplyr)


# Load data
setwd("/Users/jessymin/Documents/instacart_dataset/data")

department <- read_csv('departments.csv')
aisle <- read_csv('aisles.csv')
product <- read_csv('products.csv')
product <- product[,-1]
order <- read_csv('orders.csv')

order_products__prior <- read_csv('order_products__prior.csv')
order_products__train <- read_csv('order_products__train.csv')
order_products <- rbind(order_products__prior, order_products__train)


# Reshape data
order$order_dow <- as.factor(order$order_dow)
order$order_hour_of_day <- as.factor(order$order_hour_of_day)
order_products$reordered <- as.factor(order_products$reordered)

# Merge datasets
order_all <- order %>%
        left_join(order_products, by = 'order_id') %>%
        left_join(product, by = 'product_id') %>%
        left_join(department, by = 'department_id') %>%
        left_join(aisle, by = 'aisle_id') 

