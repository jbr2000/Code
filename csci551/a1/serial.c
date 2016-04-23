/**
 * @file serial.c 
 * @author  Spencer McWilliams <smcwilliams3@mail.csucico.edu>
 *
 * This file is to calculate a number of trapezoids used to estimate the integral of
 * a function between 100 to 600 in 14 points of precision.
 */

// Used for input and output
#include <stdio.h>
// Used for trig functions in Foo
#include <math.h>

// function for the integral
double foo(double x);
// estimate the integral
double estimate(double a, double b, double n);
// calculate relative true error
double rel_true_err_for(double approxValue);

const double acceptableError = 0.000000000000005;
const double trueValue = 4003.72090015132683;

int main() {
  printf("Goal: %.14f\n\n", trueValue);
  // initialize values
  double a = 100;
  double b = 600;
  double approxValue = 1.0;
  double relativeTrueError = 1.0;

  for (int i=4000000; i<40000000; i+=100000) {
    approxValue = estimate(a,b,i);
    relativeTrueError = rel_true_err_for(approxValue);
    printf("%i:\t%.15f\n", i, relativeTrueError);
    if ((relativeTrueError < acceptableError) && 
        (relativeTrueError > 0-acceptableError)) {
      printf("%i trapezoids works!\n", i);
      break;
    }
  }

  return 0;
}




/*------------------------------------------------------------------
 * Function:     Foo
 * Purpose:      Calculate y at a given x for the function we're
 *               analyzing.
 * Input args:   x: pretty self explanatory
 * Output:       y value for corresponding x
 */
double foo(double x) {
  return (cos(x/3)-(2*cos(x/5))+(5*sin(x/4))+8);
}

/*------------------------------------------------------------------
 * Function:     estimate 
 * Purpose:      Rough estimation of integral
 * Input args:   a: starting x
 *               b: endin x
 *               n: number of trapezoids
 * Output:       approximate value 
 */
double estimate(double a, double b, double n) {
  double h = (b-a)/n;
  double approxValue = (foo(a) + foo(b))/2.0;
  for (int i=1; i < n; i++) {
    double x_i = a + (i*h);
    approxValue += foo(x_i);
  }
  approxValue = h*approxValue;
  return approxValue;
}

/*------------------------------------------------------------------
 * Function:     rel_true_error
 * Purpose:      calculate relative true error given an approx. val
 * Input args:   approxValue: approximate value to calculate for
 * Output:       relative true error
 */
double rel_true_err_for(double approxValue) {
  double trueError = trueValue-approxValue;
  double relativeTrueError = trueError/trueValue;
  return relativeTrueError;
}
