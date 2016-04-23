// Spencer McWilliams (smcwilliams)
// Lab 8: Factorial!
// Due

#include <iostream>
using namespace std;

int input;

void get_input(int &input);
long calculation(int input_par);

int main()
{
  
  long answer;
  
  do {
    get_input(input);
  } while (input < 0);
  
  answer = calculation(input);
  
  cout << input << "! = " << answer << endl;
  
  return 0;
}

void get_input(int &input)
{
  cout << "Calculate the factorial of: ";
  cin >> input;
  
  return;
}

long calculation(int input_par)
{
  long answer(1);
  
  for (; input_par >=1; input_par--) {
    answer *= input_par;
  }
  
  return answer;
}