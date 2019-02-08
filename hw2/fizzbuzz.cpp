#include <Rcpp.h>
#include <iostream>
using namespace Rcpp;

// [[Rcpp::export]]
void fzbz(StringVector nums) {
  int n = nums.size();
  
  for(int i = 0; i < n; ++i) {
    char* arry = nums[i];
    int c = 0;
    if (strlen(arry) == 1 && arry[0] == '0') {
      c = 0;
    }
    else {
      float temp = atof(arry);
      if (temp == 0) {
        Rcout << "Not a number!" << std::endl;
        continue;
      }
      else {
        if (atoi(arry) - atof(arry) != 0) {
          Rcout << "Please input an integer!" << std::endl;
          continue;
        }
        else
          c = int(temp);
      }
    }
    if (c % 5 == 0 && c % 3 == 0)
      Rcout << "FizzBuzz" << std::endl;
    else if (c % 3 == 0)
      Rcout << "Fizz" << std::endl;
    else if (c % 5 == 0)
      Rcout << "Buzz" << std::endl;
    else
      Rcout << c << std::endl;
    
  }
}