// Spencer McWilliams (smcwilliams)
// Lab 17
// Due 12/9/2011

#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main()
{
  ifstream csv_file;
  int score_count = 0, score;
  char file_name[20];

  do
  {
    cout << "Please enter the name of the scores file: ";
    cin >> file_name;
    csv_file.open(file_name);
  } while (csv_file.fail());

  while (!csv_file.eof())
  {
    csv_file >> score;
    score_count++;
  }
  csv_file.close();

  cout << "The " << score_count << " recorded scores are:\n\n";

  int scores[score_count]new int;
  new int *p_scores = &scores[0];

  csv_file.open(file_name);
  
  while (!csv_file.eof())
  {
    for (int i = 0; i < score_count; i++)
    {
      csv_file >> score;
      p_scores[i] = score;
    }
  }

  for (int i = 0; i < score_count; i++)
  {
    cout << p_scores[i] << endl;
  }

  csv_file.close();
  
  delete p_scores;

  return 0;
}
