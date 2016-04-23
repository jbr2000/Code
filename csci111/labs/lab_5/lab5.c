#include <stdio.h>

int main()
{
  int numerator, denominator, quotient, remainder;

  printf ("This program will divide two integers.\n\n");
  printf ("Please enter the value for the numerator: ");
  scanf ("%i",&numerator);
  printf ("Please enter the value for the denominator: ");
  scanf ("%i",&denominator);
  printf ("\n");

  if (denominator == 0)
  {
  printf ("Cannot divide by zero.\n");
  }
  else
  {
  quotient = numerator/denominator;
  remainder = numerator%denominator;
  
  printf ("%i / %i = %i",numerator,denominator,quotient);  

  if (remainder > 0)
    printf ("r%i",remainder);
  
  printf ("\n");
  }

  return 0;
}
