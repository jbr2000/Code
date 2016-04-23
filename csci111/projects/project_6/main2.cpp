// Spencer McWilliams (smcwilliams)
// Project 6: Gradebook
// Due: 12/9/2011


#include <iostream>
#include <cstdlib>
#include <fstream>
#include <string>
using namespace std;

const int MAX_STUDENTS = 20;
const int MAX_EXAMS = 10;
const char DASH = '-';
const char SPACE = ' ';
const string BREAK = " |";

// Read in the name of one student
// input: student index
// output: student name into passed array eg. (names[student_index])
void get_name           (string names[],      ifstream &csv_file,     int student_index,      int &student_count);

// Read in one score
// input:
// output: one score put into scores array eg. (exam_scores[student_index][score])
int get_one_score         (ifstream &csv_file);

// Read in all scores for one student
// input:
// output: put the scores into given array (exam_scores
void get_one_students_scores (int scores[],        ifstream &csv_file,     int student_index, int& number_of_tests);

void fill_tests_array    (int scores[][MAX_EXAMS],   int array[][MAX_STUDENTS]);

int get_high         (int array[], int size);
int get_low          (int array[], int size);
double get_mean        (int array[], int number_of_tests_par);

int calculate_total      (int array[], int total_array[], int number_of_tests_par, int index);

// Passess all of the information to this function so that it may print the final output.
void display_gradebook     (int number_of_tests, int student_count, string names[], int exam_scores[][MAX_EXAMS], int total_array[], int tests[][MAX_STUDENTS]);

int main()
{
  
  // Variable Declarations
  int   student_count = 0,
  number_of_tests = 0,
  total_array[MAX_STUDENTS];
  string  names     [MAX_STUDENTS];
  char file_name[16];
  int   exam_scores [MAX_STUDENTS]  [MAX_EXAMS],
  
  /*  tests[][] is the scores of the students arranged by score.
   the first dimension is the test index, and the second dimension
   is the score of the students for that test. */
  tests     [MAX_EXAMS]   [MAX_STUDENTS];
  
  ifstream csv_file;
  
  // Open file stream. 
  {
    do
    {
      cout << "Enter the filename containing exam scores: ";
      cin >> file_name;
      csv_file.open(file_name);
    } while (csv_file.fail());
    
  }
  
  // Fill in names[] and exam_scores [][].
  // Also counts the number of total tests.
  {
    int student_index = 0;
    
    while (!csv_file.eof())
    {
      get_name(names, csv_file, student_index, student_count);
      get_one_students_scores(exam_scores[student_index], csv_file, student_index, number_of_tests);
      student_index++;
    }
  }
  
  // Fill array used for high/low/mean with correct scores.
  fill_tests_array(exam_scores, tests);
  
  display_gradebook     (number_of_tests, student_count, names, exam_scores, total_array, tests);
  
  // Close file stream.
  csv_file.close();
  
  return 0;
}

void get_name(string names[], ifstream &csv_file, int student_index, int& student_count)
{
  string student_name;
  getline(csv_file, student_name, ',');
  names[student_index] = student_name;
  student_count++;
}

int get_one_score(ifstream &csv_file)
{
  int score;
  csv_file >> score;
  return score;
}

void get_one_students_scores(int scores[], ifstream &csv_file, int student_index, int& number_of_tests)
{
  char next = ',';
  int i = 0;
  
  // Until a new line is reached:
  while (next != '\n')
  {
    scores[i] = get_one_score(csv_file);
    csv_file.get(next);
    if (csv_file.eof())
    {
      return;
    }
    
    i++;
    
    // Count the number of tests. Used to compute mean.
    if (student_index == 0)
      number_of_tests++;
  }
}

void fill_tests_array (int scores[][MAX_EXAMS], int array[][MAX_STUDENTS])
{
  for (int test_index = 0; test_index < MAX_EXAMS; test_index++)
  {
    for (int student_index = 0; student_index < MAX_STUDENTS; student_index++)
    {
      array[test_index][student_index] = scores[student_index][test_index];
/*
      cout << test_index << " , ";
      cout << student_index << endl;
*/
    }
  }
}

int get_high (int array[], int size)
{
  int high = 0;
  
  for (int i = 0; i < size; i++)
  {
    (array[i] > high)? high = array[i] : high = high;
  }
  
  return high;
}

int get_low (int array[], int size)
{
  int low = array[0];
  
  for (int i = 0; i < size; i++)
  {
    (array[i] < low)? low = array[i] : low = low;
  }
  
  return low;
}

double get_mean (int array[], int number_of_tests_par)
{
  int total = 0;
  double mean;
  
  for (int i = 0; i < number_of_tests_par; i++)
  {
    total += array[i];
  }
  
  mean = static_cast<double>(total)/number_of_tests_par;
  
  return mean;
}

int calculate_total (int array[], int total_array[], int number_of_tests_par, int index)
{
  int total = 0;
  
  for (int i = 0; i < number_of_tests_par; i++)
  {
    total += array[i];
  }
  
  total_array[index] = total;
  
  return total;
}

void display_gradebook (int number_of_tests, int student_count, string names[], int exam_scores[][MAX_EXAMS], int total_array[], int tests[][MAX_STUDENTS])
{
  cout << endl;
  cout << "Total Students: " << student_count << endl;
  cout << "Total Exams:  " << number_of_tests << endl;
  cout << endl;
  
  // Heading Row
  cout.width(15);
  cout << "Exams";
  cout << BREAK;
  for (int i = 0; i < number_of_tests; i++)
  {
    cout.width(8);
    cout << (i+1);
    if (i == (number_of_tests - 1))
    {
      cout.width(8);
      cout << "Total" << endl;
    }
  }
  
  // Line Break
  cout.fill(DASH);
  cout.width(17+(8*number_of_tests)+8);
  cout << "-" << endl;
  
  // Students and scores.
  for (int student_index = 0; student_index < student_count; student_index++)
  {
    cout.fill(SPACE);
    cout.width(15);
    cout << names[student_index];
    cout << BREAK;
    for (int test_index = 0; test_index < number_of_tests; test_index++)
    {
      cout.width(8);
      cout << exam_scores[student_index][test_index];
    }
    
    cout.width(8);
    cout << calculate_total(exam_scores[student_index], total_array, number_of_tests, student_index);
    cout << endl;
  }
  
  // Line Break
  cout.fill(DASH);
  cout.width(17+(8*number_of_tests)+8);
  cout << "-" << endl;
  
  // High Values
  cout.fill(SPACE);
  cout.width(15);
  cout << "High";
  cout.width(0);
  cout << BREAK;
  for (int i = 0; i < number_of_tests; i++)
  {
    cout.width(8);
    cout << get_high(tests[i], student_count);
  }
  cout.width(8);
  cout << get_high(total_array, student_count);
  cout << endl;
  
  // Low Values
  cout.width(15);
  cout << "Low";
  cout.width(0);
  cout << BREAK;
  for (int i = 0; i < number_of_tests; i++)
  {
    cout.width(8);
    cout << get_low(tests[i], student_count);
  }
  cout.width(8);
  cout << get_low(total_array, student_count);
  cout << endl;
  
  // Mean Values
  cout.setf(ios::showpoint);
  cout.setf(ios::fixed);
  cout.precision(1);
  
  cout.width(15);
  cout << "Mean";
  cout.width(0);
  cout << BREAK;
  for (int i = 0; i < number_of_tests; i++)
  {
    cout.width(8);
    cout << get_mean(tests[i], student_count);
  }
  cout.width(8);
  cout << get_mean(total_array, student_count);
  cout << endl;
  
  // Line Break
  cout.fill(DASH);
  cout.width(17+(8*number_of_tests)+8);
  cout << "-" << endl;
}
