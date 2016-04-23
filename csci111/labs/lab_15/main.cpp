// Spencer McWilliams (smcwilliams)
// Lab 15: Sort This!
// Due: 11/28/2011

#include <iostream>
#include <string>
using namespace std;

// Reads in integer values from the user up to max_size times or a negative
// value.  The values are stored into the numbers array.
// The function will return the number of positive integers read in.
int read_numbers(int numbers[], int max_size);

// Prints the title which is set to a width of 10 for formatting purposes.
// It will then print the contents of the array numbers up to count values.
void print_numbers(string title, const int numbers[], int count);

// Sorts the numbers array using the selection sort algorithm
void sort(int numbers[], int size);

// Swaps two integer variables
void swap(int &a, int &b);

// Returns the INDEX of the element that contains the minimum value in the
// array numbers.  The search will begin from start_index and will proceed
// up to element (size - 1)
int min_index(const int numbers[], int size, int start_index);

const int MAX_NUMBERS = 100;

int main()
{
  int numbers[MAX_NUMBERS];
  int count = read_numbers(numbers, MAX_NUMBERS);
  
  print_numbers("Begin:", numbers, count);
  sort     (numbers, count);
  print_numbers("End:", numbers, count);
  
  return 0;
}


int read_numbers(int numbers[], int max_size)
{
  int input, i = 0;
  
  cout << "Please enter up to 100 different numbers.\nIndicate that you are done by entering a\nnegative value.\n\n";
  
  do {
    cout << "=> ";
    cin >> input;
    
    if (input >= 0 and i < max_size)
    {
      numbers[i] = input;
      i++;
    }
  } while (input >= 0 and i < max_size);
  
  cout << endl;
  
  return i;
}

void print_numbers(string title, const int numbers[], int count)
{
  cout.width(10);
  cout << title;
  
  for (int i = 0; i < count; i++)
  {
    cout.width(4);
    cout << numbers[i];
  }
  
  cout << endl;
}

void sort(int numbers[], int size)
{
  for (int i = 0; i < size-1; i++)
  {
    swap(numbers[i], numbers[min_index(numbers, size, i)]);
    
    cout.width(10);
    cout << "Iteration:";
    
    for (int j = 0; j < size; j++)
    {
      cout.width(4);
      cout << numbers[j];
    }
    cout << endl;
  }
}

void swap(int &a, int &b)
{
  int holder;
  
  holder = a;
  a = b;
  b = holder;
}

int min_index(const int numbers[], int size, int start_index)
{
  int minimum_index = start_index;
  
  for (int i = start_index; i < size; i++)
  {
    (numbers[i] < numbers[minimum_index]) ? minimum_index = i : minimum_index = minimum_index;
  }
  
  return minimum_index;
}