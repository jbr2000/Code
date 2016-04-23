// Spencer McWilliams (smcwilliams)
// Lab 10: What's your type?

#include <iostream>
#include <string.h>
using namespace std;

int   const FAVORITE_NUMBER   = -3414;
char  const FAVORITE_LETTER   = '!';
double  const FAVORITE_DOUBLE   = 6.28;
bool  const FAVORITE_BOOLEAN  = 0;
string  const FAVORITE_WORD   = "Programming";


void   print_my_type(int input_par);
void  print_my_type(char input_par);
void  print_my_type(double input_par);
void  print_my_type(bool input_par);
void  print_my_type(string input_par);

int main()
{
  print_my_type(FAVORITE_NUMBER );
  print_my_type(FAVORITE_LETTER );
  print_my_type(FAVORITE_DOUBLE );
  print_my_type(FAVORITE_BOOLEAN);
  print_my_type(FAVORITE_WORD   );
  
  return 0;
}

void print_my_type(int input_par)
{
  cout << "Integer: " << input_par << endl;
}

void print_my_type(char input_par)
{
  cout << "Character: " << input_par << endl;
}

void print_my_type(double input_par)
{
  cout << "Double: " << input_par << endl;
}

void print_my_type(bool input_par)
{
  if (input_par == 0)
    cout << "Boolean: false\n";
  else
    cout << "Boolean: true\n";
}

void print_my_type(string input_par)
{
  cout << "String: " << input_par << endl;
}