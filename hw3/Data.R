library("tidyverse")
payroll <- read_csv("/home/m280data/la_payroll/City_Employee_Payroll.csv")

# Dataset for Question1 
TotalPay<- payroll %>% select(Year, `Base Pay`, `Overtime Pay`, `Other Pay (Payroll Explorer)`) %>%
  group_by(Year) %>%
  summarise(Tbase = sum(`Base Pay`, na.rm = TRUE),
            Tover = sum(`Overtime Pay`, na.rm = TRUE),
            Tother = sum(`Other Pay (Payroll Explorer)`, na.rm = TRUE),
            total = sum(Tbase, Tover, Tother)) %>%
  gather(Tbase, Tover, Tother, key = "Type", value = "Payment")
write_rds(TotalPay, "TotalPay.rds") 


