// Spencer McWilliams (smcwilliams)
// Lab 7
// My computer crashed and I had to reformat my hard drive before I could turn it in! So I have to re-do it now...
// Due: x

#include <stdio.h>

const double PI=3.1415926;
double radius, answer=0;
int choice;

static int intro();
static int option();
static double enter_radius();

int circumference(double radius_par);
int area(double radius_par);
int surface_area(double radius_par);
int volume(double radius_par);

int main()
{
  
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
        circumference(radius);
        break;
        
      case 2:
        area(radius);
        break;
        
      case 3:
        surface_area(radius);
        break;
        
      case 4:
        volume(radius);
        break;
        
      case 5:
        printf("\nThanks for playing!\n");
        return 0;
        break;
        
      default:
        break;
    }
    
  } while (choice != 5);
  
  return 0;
}



int intro()
{
  printf("Choose an option to calculate:\n");
  printf("\t(1) Circumference of a circle\n");
  printf("\t(2) Area of a circle\n");
  printf("\t(3) Surface area of a sphere\n");
  printf("\t(4) Volume of a sphere\n");
  printf("\t(5) Quit\n\n");
  
  return 0;
}

int option()
{
  int input;
  
  printf("Enter option => ");
  scanf("%i", &input);
  
  return input;
}

double enter_radius()
{
  double input;
  printf("Enter the radius => ");
  scanf("%lf", &input);
  
  return input;
}

int circumference(double radius_par)
{
  
  answer = (2*PI*radius_par);
  printf("The circumference is %.4lf\n\n",answer);
  
  return 0;
}

int area(double radius_par)
{
  
  answer = (PI*radius_par*radius_par);
  
  printf("The area is %.4lf\n\n",answer);
  
  return 0;
}

int surface_area(double radius_par)
{
  
  answer = (4*PI*radius_par*radius_par);
  
  printf("The surface area is %.4lf\n\n",answer);
  
  return 0;
}

int volume(double radius_par)
{
  
  answer = ((4/3.0)*PI*radius_par*radius_par*radius_par);
  
  printf("The volume is %.4lf\n\n",answer);
  
  return 0;
}
