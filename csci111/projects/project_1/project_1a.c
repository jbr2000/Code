// Spencer McWilliams (smcwilliams)
// Project 1a

#include <stdio.h>

int main()
{
  double average, test_score, added_scores=0;
  int number_of_tests=0;

  printf ("The following program will calculate the average\n");
  printf ("score on an exam.  You will be prompted for exam\n");
  printf ("scores until you enter a score of '-1' to indicate\n");
  printf ("that you are finished.\n\n");

  do {
  printf ("Enter score: ");
  scanf ("%lf",&test_score);
    if (test_score >= 0)
    {
    number_of_tests++;
    added_scores += test_score;
    }
  } while (test_score > -1);

  if (number_of_tests == 0)
  printf ("\nThere were no exams recorded.\n");
  else
  {
  average = added_scores/number_of_tests;
  printf ("\nRecorded %i exam(s).\n",number_of_tests);
  printf ("The average exam score was %.3lf.\n",average);
  }
  
  return 0;
}
