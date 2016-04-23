// Spencer McWilliams (smcwilliams)
// Lab 11: Simple Math
// Due: 10/24/2011

#include <stdio.h>

// Returns the result of value_1 + value_2
double add(double value_1, double value_2);

// Returns the result of value_1 - value_2
double subtract(double value_1, double value_2);

// Returns the result of value_1 * value_2
double multiply(double value_1, double value_2);

// Returns the result of numerator / denominator
double divide(double numerator, double denominator);

// Returns the minimum number between value_1 and value_2
double minimum(double value_1, double value_2);

// Returns the maximum number between value_1 and value_2
double maximum(double value_1, double value_2);

int main()
{
  double input_1, input_2, answer;
  char operator;
  
  printf("Please enter an expression (ex: 3.23 + 12): ");
  scanf("%lf", &input_1);
  scanf(" %c", &operator);
  scanf(" %lf", &input_2);
  
  switch (operator) {
    case '+':
      answer = add(input_1, input_2);
        printf("%.3f %c %.3f = %.3f\n", input_1, operator, input_2, answer);
      break;
     
    case '-':
      answer = subtract(input_1, input_2);
        printf("%.3f %c %.3f = %.3f\n", input_1, operator, input_2, answer);
      break;
    
    case 'x':
    case 'X':
    case '*':
      answer = multiply(input_1, input_2);
        printf("%.3f %c %.3f = %.3f\n", input_1, operator, input_2, answer);
      break;
      
    case '/':
      answer = divide(input_1, input_2);
        printf("%.3f %c %.3f = %.3f\n", input_1, operator, input_2, answer);
      break;
      
    case 'm':
      answer = minimum(input_1, input_2);
        printf("%.3f %c %.3f = %.3f\n", input_1, operator, input_2, answer);
      break;
      
    case 'M':
      answer = maximum(input_1, input_2);
        printf("%.3f %c %.3f = %.3f\n", input_1, operator, input_2, answer);
      break;
      
    default:
      printf("Illegal expression.\n");
      break;
  }

  
  return 0;
}



double add(double value_1, double value_2)
{
  return (value_1+value_2);
}

double subtract(double value_1, double value_2)
{
  return (value_1-value_2);
}

double multiply(double value_1, double value_2)
{
  return (value_1*value_2);
}

double divide(double numerator, double denominator)
{
  return (numerator/denominator);
}

double minimum(double value_1, double value_2)
{
  return (value_1<value_2)?(value_1):(value_2);
}

double maximum(double value_1, double value_2)
{
  return (value_1>value_2)?(value_1):(value_2);
}