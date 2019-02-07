#include <Rcpp.h>
#include <iostream>
using namespace Rcpp;

// [[Rcpp::export]]
void fzbz(StringVector nums) {
  int n = nums.size();
  
  for(int i = 0; i < n; ++i) {
    char* arry = nums[i];
    int c = 0;
    if (strlen(arry) == 1 && arry[0] == '0')
    {
      c = 0;
    }
    else
    {
      float temp = atof(arry);
      if (temp == 0)
      {
        std::cout << "Not a number!" << std::endl;
        continue;
      }
      else{
        if (atoi(arry) - atof(arry) != 0)
        {
          std::cout << "Please input an integer!" << std::endl;
          continue;
        }
        else
          c = int(temp);
      }
    }
    if (c % 5 == 0 && c % 3 == 0)
      std::cout << "FizzBuzz" << std::endl;
    else if (c % 3 == 0)
      std::cout << "Fizz" << std::endl;
    else if (c % 5 == 0)
      std::cout << "Buzz" << std::endl;
    else
      std::cout << c << std::endl;
    
  }
}