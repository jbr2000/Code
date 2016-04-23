// Spencer McWilliams (smcwilliams)
// Lab 16: Lengthy Words
// Due 12/5/2011

#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
#include <cstring>
using namespace std;

int input_length();
void count_words(int size, fstream& dictionary);

int main()
{
  int size = 0;
  fstream dictionary;
  dictionary.open("dictionary.txt");

  if (dictionary.fail())
  {
    cout << "Could not open dictionary.\n";
    exit(1);
  }

  size = input_length();
  count_words(size, dictionary);

  dictionary.close();
  
  return 0;
}







int input_length()
{
  int length;
  do {
    cout << "What length words would you like to find? ";
    cin >> length;
  } while(length <= 0);

  cout << endl;

  return length;
}

void count_words(int size, fstream& dictionary)
{
  string word;
  int count = 0;

  getline(dictionary,word);

   while (!dictionary.eof())
  {
    if (word.length() == size)
    {
      cout << word << endl;
      count++;
    }
    getline(dictionary,word);
  }

  if (count == 0)
  {
    cout << "There were no words of length " << size << " found.\n";
    exit(2);
  }
  else
    cout << endl << "Found " << count << " words of length " << size << ".\n";
}
