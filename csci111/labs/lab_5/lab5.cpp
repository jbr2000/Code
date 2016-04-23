#include <iostream>
using namespace std;

int main()
{
  int numerator, denominator, quotient, remainder;

  cout << "This program will divide two integers.\n\n";
  cout << "Please enter the value for the numerator: ";
  cin >> numerator;
  cout << "Please enter the value for the denominator: ";
  cin >> denominator;
  cout << endl;

  if (denominator == 0)
  {
  cout << "Cannot divide by zero." << endl;
  }
  else
  {
  quotient = numerator/denominator;
  remainder = numerator%denominator;
  
  cout << numerator << " / " << denominator << " = " << quotient;

  if (remainder > 0)
    cout << "r" << remainder;
  
  cout << endl;
  }

  return 0;
}
