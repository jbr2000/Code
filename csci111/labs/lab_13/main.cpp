// Spencer McWilliams (smcwilliams)
// Lab 13: Copycat
// Due 11/7/2011

#include <iostream>
#include <fstream>
#include <cstdlib>
using namespace std;

int main()
{
  ifstream  in_file;
  ofstream  copy, cat;
  char    next;

  in_file.open(   "input.txt" );
  copy.open(    "copy.txt"  );
  cat.open(  "cat.txt", ios::app);

  in_file.get(next);

  while(!in_file.eof())
  {
    copy << next;
    cat << next;

    in_file.get(next);
  }
  

  return 0;
}
