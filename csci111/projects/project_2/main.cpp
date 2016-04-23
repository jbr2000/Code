// Spencer McWilliams (smcwilliams)
// Project 2: Change Please!
// Due: 9/26/2011

#include <iostream>

int main()
{
  using namespace std;
  
  int cents, quarters, dimes, nickels, pennies, remainder, repeat;
  char decision;
  
  cout << "This program will calculate the minimal number of coins needed\nin order to make change for a given amount of cents.\n";
  
  do {
  cout << "\nPlease enter an amount in cents: ";
  cin >> cents;
  
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
  
  cout << "\nWould you like to calculate change again (Y/N)? ";
  cin >> decision;
  if (decision == 'y' || decision == 'Y') {
    repeat = 1;
  }
  else
    repeat = 0;
  
  
  } while (repeat);
  
  return 0;
}
