# Check if the input is valid
check = function (i) {
  if (is.numeric(i) != 1) {
    print (paste(i, "is not a number"))
    return(0)
  }
  else if (is.na(i) | is.infinite(i)) {
    print ("Please input an integer")
    return(0)
  }
  else if (i %% 1 != 0) {
    print (paste(i, "is not an integer." ))
    return(0)
  }
  return (1)
}

# For multiples of 3 print "Fizz"
# For multiples of 5 print "Buzz"
# For multiples of both print "FizzBuzz"

fizzbuzz = function(x) {
  for (i in x) {
    if (check(i)) {
      i <- as.integer(i)
      if (i %% 3 == 0 & i %% 5 == 0)  print("FizzBuzz")
      else if (i %% 3 == 0)  print("Fizz")
      else if (i %% 5 == 0)  print("Buzz")
      else print(i)
    }
  }
}

