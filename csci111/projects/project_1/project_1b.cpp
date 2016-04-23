// Spencer McWilliams (smcwilliams)
// Project 1b

#include <iostream>
using namespace std;

int main()
{
  double average, number_of_tests(0), test_score, added_scores(0);

  cout << "The following program will calculate the average\n";
  cout << "score on an exam.  You will be prompted for exam\n";
  cout << "scores until you enter a score of '-1' to indicate\nthat you are finished.\n\n";

  do
  {
  cout << "Enter score: ";
  cin >> test_score;
    if (test_score >= 0)
    {
    number_of_tests++;
    added_scores += test_score;
    }
  } while (test_score > -1);
  
  if (number_of_tests == 0)
  cout << "\nThere were no exams recorded.\n";
  else
  {
  average = added_scores/number_of_tests;
  cout << "\nRecorded " << number_of_tests << " exam(s).\n";
    cout.setf(ios::fixed);
    cout.setf(ios::showpoint);
    cout.precision(3);
  cout << "The average exam score was " << average << ".\n";
  }
  return 0;
}
