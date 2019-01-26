## Read data from txt files 
nVals = seq(100, 500, by = 100)
distTypes = c("gaussian", "t5", "t1")
Avg <- rep( c('PrimeAvg', 'SamplAvg'), 5)
result <- c()
N <- c()

for(n in nVals){
  N <- c(N, rep(n, 2))
}

for (dist in distTypes){
  for (n in nVals){
    oFile <- paste("/home/yunh/biostat-m280-2019-winter/hw1/n", 
                   n, "dist", dist, ".txt", sep="")
    MSE <- read.table(oFile)
    result <- c(result, MSE[, 2])
    result <- c(result, MSE[, 3])
  } 
}
table <- data.frame(n = N, Method = Avg, Gaussian = result[1:10], 
                    t5 = result[11:20], t1 = result[21:30])
table

