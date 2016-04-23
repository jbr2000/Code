// Spencer McWilliams (smcwilliams)
// Lab 6: Guess my number
// Due: 9/19/2011

#include <iostream>
using namespace std;

int main()
{
  int count(1), guess, number;

  int const UPPER_LIMIT(100);

  cout << "I am thinking of a number between 1 and " << UPPER_LIMIT << ".";

  number = 31;

  for (guess; guess != number; count++)
  {
    cout << "\n\nGuess my number: ";
    cin >> guess;

    if (guess > number)
      cout << "My number is less than " << guess << ".";

    if (guess < number)
      cout << "My number is higher than " << guess << ".";

    if (guess == number)
      cout << "You guessed my number in " << count << " guesses.\n";
  }
  
  cout << "\nThanks for playing.\n";

  return 0;
}
