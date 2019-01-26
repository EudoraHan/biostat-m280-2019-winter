## parsing command arguments
for (arg in commandArgs(TRUE)) {
  eval(parse(text = arg))
}

## 1.set random seed
set.seed (seed)

## 2. generate data according to different argument
distribution = function(dist) {
  if (dist == "gaussian"){
    x = rnorm(n)
  }
  else if (dist == "t1"){
    x = rt(n,1)
  }
  else if (dist=="t5"){
    x = rt(n,5)
  }
}

## 3.compute the primed-indexed average estimator
## check if a given integer is prime
isPrime = function(n) {
  if (n <= 3) {
    return (TRUE)
  }
  if (any((n %% 2:floor(sqrt(n))) == 0)) {
    return (FALSE)
  }
  return (TRUE)
}

## estimate mean only using observation with prime indices
estMeanPrimes = function (x) {
  n = length(x)
  ind = sapply(1:n, isPrime)
  return (mean(x[ind]))
}

## 4.compute the MSE
## compute the primed-indexed average estimator MSE
set.seed (seed)
PrimeAve <- replicate(rep, estMeanPrimes(distribution(dist)))
msePrimeAve <- sum(PrimeAve^2)/rep

## compute the classical sample average estimator MSE
set.seed (seed)
SampleAve <- replicate(rep, mean(distribution(dist)))
mseSampleAve <- sum(SampleAve^2)/rep

print(c(msePrimeAve,mseSampleAve))


