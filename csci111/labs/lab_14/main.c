// Spencer McWilliams (smcwilliams)
// Lab 14: In Reverse
// Due 11/14/2011

#include <stdio.h>

int main()
{
  FILE* input_file;
  int number, counter=0, holder[100], i=0;
  
  input_file = fopen("numbers.txt","r");
  if (input_file == NULL)
  {
    printf("Unable to open file 'numbers.txt'\n");
    return(1);
  }


  int val = fscanf(input_file,"%i",&number);

  while (val != EOF)
  {     
    holder[counter]=number;
    counter++;
    val = fscanf(input_file,"%i",&number);
  }

  counter -= 1;

  for (; counter >= 0; counter--)
  {
    printf("%i\n",holder[counter]);
  }

  return 0;
}
