library(DBI)
library(RSQLite)
library(tidyverse)
library(dplyr)

# connecting the dataset
con = dbConnect(RSQLite::SQLite(), "/home/m280data/la_parking/LA_Parking_Citations.sqlite")
dbListTables(con)

latix <- dplyr::tbl(con, "latix")

latix %>% print(width = Inf)

# Question 1
latix %>% filter(!is.na(Ticket_number)) %>% count() 
# 7656362

data <- latix %>%
  filter(!is.na(Issue_Year), !is.na(Issue_Month), 
         !is.na(Issue_Day), !is.na(Issue_Hour), 
         !is.na(Issue_Minute), !is.na(Issue_Wday)) 

data %>% arrange(desc(Issue_Year), desc(Issue_Month), desc(Issue_Day), 
                 desc(Issue_Hour), desc(Issue_Minute)) %>%
  select(Issue_Year, Issue_Month, Issue_Day, Issue_Hour, Issue_Minute) %>%
  collect() %>%
  slice(c(1, n()))

# 2019/1/25 23:58 ---2015/7/2 1:00

data %>% group_by(Issue_Year) %>%
  summarise(num = n()) %>%
  arrange(desc(num)) %>%
  head(1)
# 2017

# Question 2
# hour  12  5
data %>% group_by(Issue_Hour) %>%
  summarise(num = n()) %>%
  arrange(desc(num)) %>%
  collect() %>%
  slice(c(1, n()))

# Wednesday Monday
data %>% group_by(Issue_Wday) %>%
  summarise(num = n()) %>%
  arrange(desc(num)) %>%
  collect() %>%
  slice(c(1, n()))

#  13  31
data %>% group_by(Issue_Day) %>%
  summarise(num = n()) %>%
  arrange(desc(num)) %>%
  collect() %>%
  slice(c(1, n()))

# August 2yue
data %>% group_by(Issue_Month) %>%
  summarise(num = n()) %>%
  arrange(desc(num)) %>%
  collect() %>%
  slice(c(1, n()))


# Question 3 : Which car: "Toyota"
latix %>% filter(!is.na(Make)) %>% 
  group_by(Make) %>%
  summarise(num = n()) %>%
  arrange(desc(num)) %>%
  head(1)


# Question 4 : How many color (103) Which color (BK)
colordata <- latix %>% filter(!is.na(Color)) %>% 
  group_by(Color) %>%
  summarise(num = n()) %>%
  arrange(desc(num))

colordata %>% summarise(num = n())
colordata %>% head(1)

# Question 5: most common tickets type :NO PARK/STREET CLEAN 
latix %>% filter(!is.na(Violation_Description)) %>% 
  group_by(Violation_Description) %>%
  summarise(num = n()) %>%
  arrange(desc(num)) %>%
  head(1)

#Question 6: How much money was collected on parking tickets






 