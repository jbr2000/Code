// Spencer McWilliams (smcwilliams)
// Lab 4


#include <iostream>
using namespace std;

int main()
{
  int perimeter, area, height, width;

  cout << "This program will calculate the perimeter and area of a rectangle.\n\n";
  cout << "Enter the height of the rectangle: ";
  cin >> height;
  cout << "Enter the width of the rectangle: ";
  cin >> width;
  cout << endl;

  perimeter = (2*height)+(2*width);
  area = (width * height);

  cout << "The perimeter is " << perimeter << "." << endl;
  cout << "The area is " << area << "." << endl;

  return 0;
}
