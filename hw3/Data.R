library("tidyverse")
payroll <- read_csv("/home/m280data/la_payroll/City_Employee_Payroll.csv")

# Dataset for Question1 
TotalPay<- payroll %>% 
  select(Year, `Base Pay`, `Overtime Pay`, `Other Pay (Payroll Explorer)`) %>%
  group_by(Year) %>%
  summarise(Tbase = sum(`Base Pay`, na.rm = TRUE),
            Tover = sum(`Overtime Pay`, na.rm = TRUE),
            Tother = sum(`Other Pay (Payroll Explorer)`, na.rm = TRUE),
            total = sum(Tbase, Tover, Tother)) %>%
  gather(Tbase, Tover, Tother, key = "Type", value = "Payment")
write_rds(TotalPay, "TotalPay.rds") 

# Dataset for Question2
HighPay <- payroll %>%
  select(Year, `Department Title`, `Job Class Title`, `Total Payments`, `Base Pay`,
         `Overtime Pay`, `Other Pay (Payroll Explorer)`) %>%
  arrange(desc(`Total Payments`))
write_rds(HighPay, "HighPay.rds")          
         
# Dataset for Question3
MeanPay <- payroll %>%
  group_by(Year, `Department Title`) %>%
  summarise(MeanTotal = mean(`Total Payments`, na.rm = TRUE),
            MeanBase = mean(`Base Pay`, na.rm = TRUE),
            MeanOver = mean(`Overtime Pay`, na.rm = TRUE),
            MeanOther = mean(`Other Pay (Payroll Explorer)`, na.rm = TRUE)) %>%
  arrange(desc(MeanTotal))
write_rds(MeanPay, "MeanPay.rds") 

MedianPay <- payroll %>%
  group_by(Year, `Department Title`) %>%
  summarise(MedianTotal = median(`Total Payments`, na.rm = TRUE),
            MedianBase = median(`Base Pay`, na.rm = TRUE),
            MedianOver = median(`Overtime Pay`, na.rm = TRUE),
            MedianOther = median(`Other Pay (Payroll Explorer)`, na.rm = TRUE)) %>%
  arrange(desc(MedianTotal))
write_rds(MedianPay, "MedianPay.rds") 

# Dateset for Question4
HighCost <- payroll %>%
  group_by(Year, `Department Title`) %>%
  summarise(sumTotal = sum(`Total Payments`, na.rm = TRUE),
            sumBase = sum(`Base Pay`, na.rm = TRUE),
            sumOver = sum(`Overtime Pay`, na.rm = TRUE),
            sumOther = sum(`Other Pay (Payroll Explorer)`, na.rm = TRUE),
            sumCost = sum(`Average Benefit Cost`, na.rm = TRUE)) %>%
  arrange(desc(sumCost)) %>%
  select(Year, `Department Title`, sumTotal, sumBase, 
         sumOver, sumOther, sumCost)
write_rds(HighCost, "HighCost.rds")


