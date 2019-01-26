# autoSim.R 
nVals = seq(100, 500, by = 100)
distTypes = c("gaussian", "t5", "t1")

for (n in nVals) {
  for (dist in distTypes) {
    oFile <- paste("n", n, "dist", dist, ".txt", sep="")
    sysCall <- paste("nohup Rscript runSim.R n=", n, 
                     " dist=", shQuote(shQuote(dist)), " seed=", 280, 
                     " rep=", 50, " > ", oFile, sep="")
    system(sysCall)
    print(paste("sysCall=", sysCall, sep=""))
  }
}
