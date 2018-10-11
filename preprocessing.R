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

# Create user profile
order1 <- order_all %>% filter(user_id %in% c(1:3))


user_profile <- order1 %>%
        group_by(user_id) %>%
        summarise(
            num_orders = length(unique(order_id)),
            num_orders2 = max(order_number),
            order_interval = mean(days_since_prior_order, na.rm=T),
            avg_item_per_order = length(product_id)/length(unique(order_id))
        )


order2 <- order %>% filter(user_id %in% c(1:3))
order2$order_dow <- as.numeric(order2$order_dow)
order2$weekend <- 0
order2$weekend[order2$order_dow %in% c(0,1,6)] <- 1

# 아래 코드는 값이 'c(0,1,6)=1'로 대체됨
order2$weekend <- recode(order2$order_dow, "c(0,1,6)=1", .default='0')
    
    
user_profile2 <- order2 %>%
    group_by(user_id) %>%
    summarise(
        num_orders = length(unique(order_id)),
        order_interval = mean(days_since_prior_order, na.rm=T),
        # day 0,1,6에 주문한 횟수의 비율
        order_dow_weekend = sum(weekend)/length(unique(order_id))
    )

user_profile2 <- order2 %>%
    group_by(user_id) %>%
    summarise(
        num_orders = length(unique(order_id)),
        order_interval = mean(days_since_prior_order, na.rm=T),
        # day 0,1,6에 주문한 횟수의 비율
        order_weekend_ratio = sum(weekend)/num_orders*100
    )
