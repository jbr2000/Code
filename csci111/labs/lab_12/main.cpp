// Spencer McWilliams (smcwilliams)
// Lab 11: Scores!
// Due: 10/31/2011

#include <iostream>
#include <fstream>
#include <cstdlib>
using namespace std;

int main()
{
  double    average = 0;
  int     score_count, minimum = 100, maximum = 0;
  ifstream  score_sheet;
  
  score_sheet.open("scores.dat");
  
  if (score_sheet.fail())
  {
    cout << "Could not open file 'scores.dat'.\n";
    exit(1);
  }
  
  score_sheet >> score_count;
  
  for (int count = score_count, current_score; count > 0; count--)
  {
    score_sheet >> current_score;
    average += current_score;
    minimum = (current_score <= minimum)?current_score:minimum;
    maximum = (current_score >= maximum)?current_score:maximum;
  }
  
  average /= score_count;
  
  cout.setf(ios::fixed);
  cout.setf(ios::showpoint);
  cout.precision(2);
  
  cout << "Here are some stats about your scores:\n";
  cout << "\t* " << score_count << " scores were recorded.\n";
  cout << "\t* The average score was " << average << "." << endl;
  cout << "\t* The minimum score was " << minimum << "." << endl;
  cout << "\t* The maximum score was " << maximum << "." << endl;
  
  score_sheet.close();
  
  return 0;
}
