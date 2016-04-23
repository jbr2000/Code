#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>

#define dbg if(1)

int main() {
  double ** matrix_a;
  int n, /* Width of non-augmented matrix */
      i, /* Used for for loops */
      j, /* Used for for loops */
      row_size; /* number of elements in row */

  /* Seed RNGs */
  srand48(time(NULL));
  srand(time(NULL));

  /* Get n */
  dbg printf("N: ");
  scanf("%i", &n);
  dbg printf("N = %d\n", n);
  row_size = n+1;

  /* Allocate memory for matrix */
  matrix_a = (double**) malloc(sizeof(double*)*n);
  for(i=0; i<n; i++)
    matrix_a[i] = (double*) malloc(sizeof(double)*row_size);

  /* Initialize matrix */
  for(i=0; i<n; i++) {
    for(j=0; j<row_size; j++) {
      double element = drand48() * 1000000;
      if(rand()%2) element = element*-1;
      matrix_a[i][j] = element;
      dbg printf("[%i]:\t%.6f\n", (i*row_size)+j, matrix_a[i][j]);
    }
  }

  /* Annihilation */
  for(i=0; i<n; i++) {
    /* Pivoting */
    int max_index = 0;
    double max_value = 0;
    for(j=0; j<n; j++) { /* Determine index of row (j) with max value in column i */
      double cur_value = matrix_a[j][i];
      if(cur_value >= max_value) {
        max_index = j;
        max_value = cur_value;
      }
    }
    /* Perform pivot */
    double * temp_row = matrix_a[max_index];
    matrix_a[max_index] = matrix_a[i];
    matrix_a[i] = temp_row;
  }
  
  return 0;
}
