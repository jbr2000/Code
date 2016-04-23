// Spencer McWilliams (smcwilliams)
// Project 3: Multiplication Chart
// Due 10/17/2011

#include <iostream>
using namespace std;

int const FIELD_WIDTH(10);
char const FILL_CHAR('-');

void row1(int start_par, int end_par);
void line_spacer(int start_par, int end_par);
void table(int start_par, int end_par);

int main()
{
  int start, end;

  cout << "Please enter a starting value: ";
  cin >> start;
    do {
  cout << "Please enter an ending value: ";
  cin >> end;
    } while (end < start);
  
  
  
  row1(start, end);
  line_spacer(start, end);
  table(start, end);
  
  return 0;
}



void row1(int start_par, int end_par)
{
  int column;
  
  column = start_par;
  
  cout << endl;
  cout.width(FIELD_WIDTH+2);
  cout << "|";
  for (; column <= end_par; column++) {
    cout.width(FIELD_WIDTH);
    cout << column;
  }
  cout << endl;
  
}

void line_spacer(int start_par, int end_par)
{
  int column;
  
  column = start_par;
  
  cout.width(FIELD_WIDTH+2);
  cout.fill(FILL_CHAR);
  cout << "|";
  for (; column <= end_par; column++) {
    cout.width(FIELD_WIDTH);
    cout << "-";
  }
  cout << endl;
}

void table(int start_par, int end_par)
{
  int column, row;
  
  cout.fill(' ');
  
  
  row = start_par;
  
  for (; row <= end_par; row++)
  {
    column = start_par;
    
    cout.width(10);
    cout << row << " |";
    
    for (; column <= end_par; column++) {
      cout.width(10);
      cout << (row*column);
    }
    cout << endl;
  }
}