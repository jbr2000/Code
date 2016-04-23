// Spencer McWilliams (smcwilliams)
// Project 4: FUNctions!
// Due: 10/31/2011

#include <iostream>
#include <cmath>
#include <string>
using namespace std;

// Acquire a positive integer from the user.
int  get_positive_integer();

// Determines whether the number is odd or even.
bool   is_odd        (int number);
// Determines if 'i' from print_factor_list is a factor of the number.
bool   is_factor       (int number, int factor);
// Determines if the number is a prime number.
bool   is_prime      (int number);
// Determines the larges prime number less than the given number.
// Uses "is_prime(int number)".
int  largest_prime     (int number);
// Determines the square root of the given number.
double square_root     (int number);
// Determines the value of the number squared.
long   squared       (int number);
// Determines the value of the number cubed.
long   cubed         (int number);

// Tells the user the value of the number it is analyzing.
void   print_response_intro(int number);

// Prints the facts based on the types of values.
void   print_fact      (string fact);
void   print_fact      (string fact, int  value);
void   print_fact      (string fact, long   value);
void   print_fact      (string fact, double value);

// Prints a list of factors of a given number.
void   print_factor_list   (int number);

int main()
{
  int number = get_positive_integer();
  
  print_response_intro(number);
  
  print_fact(is_odd  (number) ? "odd"   : "even"   );
  print_fact(is_prime(number) ? "prime" : "not prime");
  print_fact("square root",   square_root  (number));
  print_fact("value squared", squared    (number));
  print_fact("value cubed",   cubed    (number));
  print_fact("largest prime", largest_prime(number));
  
  print_factor_list(number);
  
  return 0;
}

int get_positive_integer()
{
  int input;
  
  do
  {
    cout << "Please enter a positive number: ";
    cin >> input;
  }while (input <= 0);
  
  cout << endl;
  
  return input;
}

bool is_odd(int number)
{
  return ((number%2) != 0);
}

bool is_factor(int number, int factor)
{
  return ((number%factor) == 0);
}

/* This routine consists in dividing (number) by each integer (m) which is
greater than 1 and less than or equal to the square root of the number (i).
If the result of any of these divisions is an integer, then number is not a
prime, otherwise, it is a prime.*/
bool is_prime(int number)
{
  for (int m=2, i=(sqrt(number)); m<=i; m++)
  {
    if ((number%m)==0)
      return false;
  }

  return true;
}

int largest_prime(int number)
{
  while (is_prime(number)==false)
  {
    number--;
  }

  return (number);
}

double square_root(int number)
{
  return (sqrt(number));
}

long squared(int number)
{
  return (number*number);
}

long cubed(int number)
{
  return (number*number*number);
}

void print_response_intro(int number)
{
  cout << "Here are some facts about the number " << number << ":\n";
}


// Prints the fact and information based on values.
void print_fact(string fact)
{
  cout << "\t* it is " << fact << "." <<endl;
}

void print_fact(string fact, int value)
{
  cout << "\t* its " << fact << " is " << value << "." << endl;
}

void print_fact(string fact, long value)
{
  cout << "\t* its " << fact << " is " << value << "." << endl;
}

void print_fact(string fact, double value)
{
  cout.setf(ios::fixed);
  cout.setf(ios::showpoint);
  cout.precision(3);
  
  cout << "\t* its " << fact << " is " << value << "." << endl;
}

// Prints a list of factors of given number.
void print_factor_list(int number)
{
  cout << "\t* its factors are:";
  
  for (int i=1; i <= (number/2); i++)
  {
    if (is_factor(number, i) == true)
    {
      cout << " " << i;
      if (i != number)
        cout << ",";
    }
  }
  cout << ".\n";
}
