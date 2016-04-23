// Spencer McWilliams (smcwilliams)
// Project 2: Change Please!
// Due: 9/26/2011

#include <iostream>

  int cents, quarters, dimes, nickels, pennies, remainder, repeat;
  char decision;

void entry(int& input1);
void calculate(int cents_par);
void loop(int& input1);

int main()
{
  using namespace std;
  
  cout << "This program will calculate the minimal number of coins needed\nin order to make change for a given amount of cents.\n";
  
  
  do {

  entry(cents);  
  calculate(cents);
  loop(repeat);
  
  } while (repeat);
  
  return 0;
}









// GET THE AMOUNT OF CENTS
void entry(int& input1)
{
using namespace std;
  cout << "\nPlease enter an amount in cents: ";
  cin >> input1;

return;
}

// DECIDE WHETHER TO LOOP OR NOT
void loop(int& output)
{
using namespace std;
  char decision;

  cout << "\nWould you like to calculate change again (Y/N)? ";
  cin >> decision;
  if (decision == 'y' || decision == 'Y') {
    output = 1;
  }
  else
    output = 0;
return;
}

// CALCULATE THE VALUE OF EACH AND OUTPUT VALUES
void calculate(int cents_par)
{
using namespace std;
  if (cents >= 0) {
    quarters = cents/25;
    remainder = cents%25;
    dimes = remainder/10;
    remainder %= 10;
    nickels = remainder/5;
    remainder %= 5;
    pennies = remainder;
    
    cout << "\nThe optimal change for " << cents << " cent(s) is:\n";
    
    if (quarters == 1)
    cout << "\t" << quarters << " quarter\n";
    if (quarters > 1)
    cout << "\t" << quarters << " quarters\n";
    if (dimes == 1)
    cout << "\t" << dimes << " dime\n";
    if (dimes > 1)
    cout << "\t" << dimes << " dimes\n";
    if (nickels == 1)
    cout << "\t" << nickels << " nickel\n";
    if (nickels > 1)
    cout << "\t" << nickels << " nickels\n";
    if (pennies == 1)
    cout << "\t" << pennies << " penny\n";
    if (pennies > 1)
    cout << "\t" << pennies << " pennies\n";
  }
  else
    cout << "\nCannot calculate negative change.\n";

return;
}
