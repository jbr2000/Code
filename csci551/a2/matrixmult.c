#include <mpi.h>
#include <math.h>
#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

/* DEFINITIONS */
#define dbg 0
#define ijk 0
#define ikj 1
#define kij 2

/* FUNCTION SIGNATURES */

/* Get_input
 * a_p: initialized A matrix
 * b_p: initialized B matrix
 * form_p: initialized form
 * n: number of rows/columns
 */
void Get_input(int rank, int * form_p, int ** a_p, int ** b_p, int * n);

/* Print_matrix
 * msg: message to be printed
 * matrix_p: matrix to print
 */
void Print_matrix(char * msg, int * matrix_p, int height, int width);

int main() {
/* Matrix A */
  int * a;
/* Matrix B */
  int * b;
/* Matrix C */
  int * c;
/* Local A  */
  int * local_a;
/* Local C */
  int * local_c;
/* Number of rows to send to each process */
  int * send_counts;
/* Displacement of scatter */
  int * displacements;
/* width/height of matricies */
  int n;
/* Number of rows to send to each process (undjusted) */
  int local_n;
/* Algorithm form */
  int form;
/* Sum for keeping track of displacements */
  int sum = 0;
/* Message placeholder for Print_matrix */
  char msg[50];
/* MPI Variables */
  int comm_size,
      my_rank,
      remainder;
  double start_time, elapsed_time;
  const int ROOT = 0;

/* Initialize MPI */
  MPI_Init(NULL, NULL);
/* Retrieve comm_size */
  MPI_Comm_size(MPI_COMM_WORLD, &comm_size);
/* Retrieve my_rank */
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
  if(dbg) printf("[%i]:comm_size: %i\n", my_rank, comm_size);
/* Gather input */
  if(!my_rank) Get_input(my_rank, &form, &a, &b, &n);
/* Block for timing */
  MPI_Barrier(MPI_COMM_WORLD);
  start_time = MPI_Wtime();
/* Broadcast n */
  MPI_Bcast(&n, 1, MPI_INT, ROOT, MPI_COMM_WORLD);
  if(dbg) printf("[%i]:n: %i\n", my_rank, n);
/* Allocate C for ROOT */
  if(!my_rank) c = malloc(sizeof(int) * pow(n,2));
/* Allocate mem for B for all other processes */
  if(my_rank) b = malloc(sizeof(int) * pow(n,2));
/* Broadcast B */
  MPI_Bcast(b, pow(n,2), MPI_INT, ROOT, MPI_COMM_WORLD);
/* Broadcast form */
  MPI_Bcast(&form, 1, MPI_INT, ROOT, MPI_COMM_WORLD);
  if(dbg && n < 11) {
    sprintf(msg, "[%i]:B:", my_rank);
    Print_matrix(msg, b, n, n);
    printf("[%i]:Form: %i\n", my_rank, form);
  }

/* Calculate send_counts and displacements */
  sum =0;
  send_counts   = malloc(sizeof(int) * comm_size);
  displacements = malloc(sizeof(int) * comm_size);
  local_n = n / comm_size;
  remainder = n % comm_size;
  for(int i = 0; i < comm_size; i++) {
    send_counts[i] = local_n;
    if (i < remainder) send_counts[i]++;
    send_counts[i] = send_counts[i] * n;
    displacements[i] = sum;
    sum += send_counts[i];
  }
  if(dbg && !my_rank)
    for(int i = 0; i < comm_size; i++)
      printf("[%i]:send_counts[%i]: %i\n", my_rank, i, send_counts[i]);

/* Allocate memory for local_a and local_c for each process */
  local_a = malloc(sizeof(int) * send_counts[my_rank] * n);
  local_c = malloc(sizeof(int) * send_counts[my_rank] * n);
/* Initialize local_c to all 0s */
  for(int i = 0; i < send_counts[my_rank]; i++)
    local_c[i] = 0;
  if(dbg) printf("[%i]: local_a and local_c have been allocated with size [%i]\n", my_rank, send_counts[my_rank]);

/* Scatter A through all processes */
  MPI_Scatterv(a, send_counts, displacements, MPI_INT, local_a, send_counts[my_rank], MPI_INT, ROOT, MPI_COMM_WORLD);
  if(dbg && n < 11) {
    printf("[%i]: A has been scattered...\n", my_rank);
    sprintf(msg, "[%i]:local_a:", my_rank);
    Print_matrix(msg, local_a, send_counts[my_rank]/n, n);
  }
/* Perform multiplication */
  switch (form) {
    case ijk:
      for(int i = 0; i < send_counts[my_rank]/n; i++)
        for(int j = 0; j < n; j++)
          for(int k = 0; k < n; k++)
            local_c[(n * i) +j] += local_a[(n * i) + k] * b[(n * k) + j];
      break;
    case ikj:
      for(int i = 0; i < send_counts[my_rank]/n; i++)
        for(int k = 0; k < n; k++)
          for(int j = 0; j < n; j++)
            local_c[(n * i) +j] += local_a[(n * i) + k] * b[(n * k) + j];
      break;
    case kij:
      for(int k = 0; k < send_counts[my_rank]/n; k++)
        for(int i = 0; i < n; i++)
          for(int j = 0; j < n; j++)
            local_c[(n * i) +j] += local_a[(n * i) + k] * b[(n * k) + j];
      break;
    default: assert(0);
  }
  if(dbg && n < 11) {
    sprintf(msg, "[%i]:local_c:", my_rank);
    Print_matrix(msg, local_c, send_counts[my_rank]/n, n);
  }

/* Gather results from local_c in children to c in ROOT */
  MPI_Gatherv(local_c, send_counts[my_rank], MPI_INT, c, send_counts, displacements, MPI_INT, ROOT, MPI_COMM_WORLD);

/* Calculate time */
  elapsed_time = MPI_Wtime() - start_time;

  if(!my_rank) {
/* Print time */
    printf("%.6e\n", elapsed_time);
    if(dbg && n < 11) {
      sprintf(msg, "Resulting C Matrix in ROOT!!!");
      Print_matrix(msg, c, n, n);
    }
  }
  
/* Finalize MPI */
  MPI_Finalize();

  return 0;
}



/* FUNCTION DEFINITIONS */ 

void Get_input(int rank,
    int *form,
    int ** a_p,
    int ** b_p,
    int * n) {
  char input[20];
  char msg[30];
  /* Form */
  if(dbg)printf("Form: "); fflush(stdout); scanf("%s", input);
  if(!strcmp(input, "ijk")) *form = ijk;
  else if(!strcmp(input, "ikj")) *form = ikj;
  else if(!strcmp(input, "kij")) *form = kij;
  else assert(0);
  /* Flag */
  if(dbg)printf("Flag: "); fflush(stdout); scanf("%s", input);
  /* N */
  if(dbg)printf("N: "); fflush(stdout); scanf("%i", n);
  /* allocate memory for a and b */
  int n_s = pow(*n,2);
  *a_p = (int*) malloc(sizeof(int)*n_s);
  *b_p = (int*) malloc(sizeof(int)*n_s);
  /* initialize matricies for R */
  if(!strcmp(input, "R")) {
    srand(time(NULL));
    for (int i=0; i < n_s; i++) {
      (*a_p)[i] = rand() % 100;
      (*b_p)[i] = rand() % 100;
    }
  } else {
    /* initalize matricies for I */
    if(!strcmp(input, "I")) {
      for(int i = 0; i < n_s; i++) {
        scanf("%i", (*a_p)+i);
      }
      for(int i = 0; i < n_s; i++) {
        scanf("%i", (*b_p)+i);
      }
    }
  }
  if(dbg && *n < 11){
    sprintf(msg,"A from input:");
    Print_matrix(msg, *a_p, *n, *n);
    sprintf(msg,"B from input:");
    Print_matrix(msg, *b_p, *n, *n);
  }
}

void Print_matrix(char * msg, int * matrix_p, int height, int width) {
  printf("%s\n", msg);
  for(int i = 0; i < height; i++) {
    for(int j = 0; j < width; j++)
      printf("%i\t", matrix_p[i * width + j]);
    printf("\n");
  }
}
