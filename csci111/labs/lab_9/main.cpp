// Spencer McWilliams (smcwilliams)
// Lab 9
// I wrote the original with Fxn calls haha
// Due: 10/10/2011

#include <iostream>
#include <cmath>
using namespace std;

void  intro();
int   option();
double  enter_radius();

double circumference  (double radius_par);
double area       (double radius_par);
double surface_area   (double radius_par);
double volume       (double radius_par);



int main()
{
  cout.setf(ios::fixed);
  cout.setf(ios::showpoint);
  cout.precision(4);
  
  double  radius, answer=0;
  int   choice;
  
  intro();
  
  do
  {
    
    do
    {
      choice = option();
    } while (choice <1 || choice >5);
    
    if (choice >=1 && choice <5)
      radius = enter_radius();
    
    switch (choice)
    {
      case 1:
        answer = circumference(radius);
        cout << "The circumference is " << answer << endl << endl;
        break;
        
      case 2:
        answer = area(radius);
        cout << "The area is " << answer << endl << endl;
        break;
        
      case 3:
        answer =surface_area(radius);
        cout << "The answer is " << answer << endl << endl;
        break;
        
      case 4:
        answer = volume(radius);
        cout << "The circumference is " << answer << endl << endl;
        break;
        
      case 5:
        cout << "\nThanks for playing!\n";
        break;
        
      default:
        break;
    }
    
  } while (choice != 5);
  
  return 0;
}



void intro()
{
  cout << "Choose an option to calculate:\n";
  cout << "\t(1) Circumference of a circle\n";
  cout << "\t(2) Area of a circle\n";
  cout << "\t(3) Surface area of a sphere\n";
  cout << "\t(4) Volume of a sphere\n";
  cout << "\t(5) Quit\n\n";
  
}

int option()
{
  int input;
  
  cout << "Enter option => ";
  cin >> input;
  
  return input;
}

double enter_radius()
{
  double input;
  cout << "Enter the radius => ";
  cin >> input;
  
  return input;
}

double circumference(double radius_par)
{
  return (2*M_PI*radius_par);
}

double area(double radius_par)
{
  return (M_PI*pow(radius_par,2));
}

double surface_area(double radius_par)
{
  return (4*M_PI*pow(radius_par,2));
}

double volume(double radius_par)
{
  return ((4/3.0)*M_PI*pow(radius_par,3));
}
