# Check if the input is valid
# For multiples of 3 print "Fizz"
# For multiples of 5 print "Buzz"
# For multiples of both print "FizzBuzz"

fizzbuzz = function(x) {
  for (i in x) {
    if (!is.numeric(i)) {
      print (paste(i, "is not a number!" ))
    }
    else if (is.na(i) | is.infinite(i)) {
      print ("Please input an integer")
    }
    else if (i %% 1 != 0) {
      print (paste(i, "is not an integer!" ))
    }
    else {
      i <- as.integer(i)
      if (i %% 3 == 0 & i %% 5 == 0)  print("FizzBuzz")
      else if (i %% 3 == 0)  print("Fizz")
      else if (i %% 5 == 0)  print("Buzz")
      else print(i)
    }
  }
}