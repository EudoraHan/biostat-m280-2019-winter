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
  summarise(`Mean Total Pay` = mean(`Total Payments`, na.rm = TRUE),
            `Mean Base Pay` = mean(`Base Pay`, na.rm = TRUE),
            `Mean Overtime Pay` = mean(`Overtime Pay`, na.rm = TRUE),
            `Mean Other Pay` = mean(`Other Pay (Payroll Explorer)`, na.rm = TRUE)) %>%
  arrange(desc(`Mean Total Pay`))
write_rds(MeanPay, "MeanPay.rds") 

MedianPay <- payroll %>%
  group_by(Year, `Department Title`) %>%
  summarise(`Median Total Pay` = median(`Total Payments`, na.rm = TRUE),
            `Median Base Pay` = median(`Base Pay`, na.rm = TRUE),
            `Median Overtime Pay` = median(`Overtime Pay`, na.rm = TRUE),
            `Median Other Pay` = median(`Other Pay (Payroll Explorer)`, na.rm = TRUE)) %>%
  arrange(desc(`Median Total Pay`))
write_rds(MedianPay, "MedianPay.rds") 

# Dateset for Question4
HighCost <- payroll %>%
  group_by(Year, `Department Title`) %>%
  summarise(`Total Pay` = sum(`Total Payments`, na.rm = TRUE),
            `Base Pay` = sum(`Base Pay`, na.rm = TRUE),
            `Overtime Pay` = sum(`Overtime Pay`, na.rm = TRUE),
            `Other Pay` = sum(`Other Pay (Payroll Explorer)`, na.rm = TRUE),
            `Total Cost` = sum(`Average Benefit Cost`, na.rm = TRUE)) %>%
  arrange(desc(`Total Cost`)) %>%
  select(Year, `Department Title`, `Total Cost`, `Base Pay`, 
         `Overtime Pay`, `Other Pay`, `Total Cost`)
write_rds(HighCost, "HighCost.rds")

# Which department have the hightest permanent bonus pay?
bonus <- payroll %>%
  group_by(Year, `Department Title`) %>%
  summarise(`Bonus` = sum(`Permanent Bonus Pay`, na.rm = TRUE)) %>%
  arrange(desc(`Bonus`)) %>%
  select(Year, `Department Title`, `Bonus`)
write_rds(bonus, "bonus.rds")
  
  
  