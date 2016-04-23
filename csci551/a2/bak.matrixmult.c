/**
 * @file matrixmult.c
 * @author Spencer McWilliams
 */

/* LIBRARIES */
#include <mpi.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

/* DEFINITIONS */
#define dbg 0
#define ijk 0
#define ikj 1
#define kij 2

/* FUNCTION SIGNATURES */
void Get_input(int rank, int * form, int ** a_p, int ** b_p, int * n);
void Print_matrix(int * matrix_p, int n);

int main() {
  /* General Variables */
  int * a;              /* A matrix */
  int * b;              /* B matrix */
  int * c;              /* C matrix */
  int * local_a;        /* Rows of A to be used in computation */
  int * local_c;        /* Partial of C computed by a process */
  int n;                /* Size of matricies is n x n */
  int local_n;          /*  */
  int form;             /* Integer representation of multiplication form */
  char flag;            /* Character representation of matrix initialization flag */
  /* MPI Variables */
  int local_matrix,     /* Partial matrix calculated by process */
      comm_size,        /* Processors */
      my_rank,          /* Rank of Process */
      remainder;        /* Remaining rows */
  const int ROOT = 0;   /* Root process rank always 0 */
  double start_time,   /* Start time of process */
         elapsed;       /* Total elapsed time */


  /* Start MPI */
  MPI_Init(NULL, NULL);
  /* Number of Processes */
  MPI_Comm_size(MPI_COMM_WORLD, &comm_size);
  /* Get my_rank */
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
  /* Retreiving input from process 0 */
  if(!my_rank) Get_input(my_rank, &form, &a, &b, &n);
  /* Block to start timing */
  MPI_Barrier(MPI_COMM_WORLD);
  /* Start timer */
  start_time = MPI_Wtime();

  /* Broadcast n */
  MPI_Bcast(&n, 1, MPI_INT, ROOT, MPI_COMM_WORLD);
  /* Allocate C */
  c = malloc(sizeof(int) * pow(n, 2));
  /* Allocate B */
  if(my_rank) b = malloc(sizeof(int) * pow(n, 2));
  /* Broadcast B */
  MPI_Bcast(b, pow(n, 2), MPI_INT, ROOT, MPI_COMM_WORLD);
  /* Broadcast form */
  MPI_Bcast(&form, 1, MPI_INT, ROOT, MPI_COMM_WORLD);

  /* ScatterV Variables */
  int sum = 0;                                           /* Used to reain offest for displacements */
  int * send_counts = malloc(sizeof(int) * comm_size);   /* Number of elements to be sent to each process */
  int * displacements = malloc(sizeof(int) * comm_size); /* Entry i specifies the displacement (relative to sendbuf) from which to take the outgoing data to process i */

  /* local_n is the amount of rows that can be evenly distributed to all processes */
  local_n = n / comm_size;
  /* Calculate how many rows are left over */
  remainder = n % comm_size;
  /* Initialize send_counts */
  for(int i = 0; i < comm_size; i++){
    send_counts[i] = local_n * n;
    /* Split remaining rows between first n processes (n = remainder) */
    if(i < remainder) send_counts[i]++;
    /* Displcement for process i is sum of number of already scattered rows */
    displacements[i] = sum;
    /* Sum is incremented by how many rows have been allocated for i process */
    sum += send_counts[i];
  }
  /* local_a will be the rows used for computation within the given process */
  local_a = malloc(sizeof(int) * send_counts[my_rank]);
  /* local_c will be the result of the computation within the given process */
  local_c = malloc(sizeof(int) * send_counts[my_rank]);
  /* Initialize c */
  for(int i=0; i<send_counts[my_rank]; i++) local_c[i] = 0;
  /* Scatter rows between processes */
  MPI_Scatterv(a, send_counts, displacements, MPI_INT, local_a, send_counts[my_rank], MPI_INT, ROOT, MPI_COMM_WORLD);

  /* Perform local multiplication */
  switch (form) {
    case ijk:
      for(int i = 0; i < local_n; i++)
        for(int j = 0; j < n; j++)
          for(int k = 0; k < n; k++)
            local_c[(n * i) +j] += local_a[(n * i) + k] * b[(n * k) + j];
      break;
    case ikj:
      for(int i = 0; i < local_n; i++)
        for(int k = 0; k < n; k++)
          for(int j = 0; j < n; j++)
            local_c[(n * i) +j] += local_a[(n * i) + k] * b[(n * k) + j];
      break;
    case kij:
      for(int k = 0; k < local_n; k++)
        for(int i = 0; i < n; i++)
          for(int j = 0; j < n; j++)
            local_c[(n * i) +j] += local_a[(n * i) + k] * b[(n * k) + j];
      break;
    default:
      assert(0);
  }

  /* Gather partial C from each process */
  MPI_Gatherv(local_c, send_counts[my_rank], MPI_INT, c, send_counts, displacements, MPI_INT, ROOT, MPI_COMM_WORLD);
  /* Compute Time */
  elapsed = MPI_Wtime() - start_time;
  if(!my_rank) printf("%.6e\n", elapsed);

  /* Finalize MPI, duh */
  MPI_Finalize();

  return 0;
}

void Get_input(int rank,
    int *form,
    int ** a_p,
    int ** b_p,
    int * n) {
  char input[20];
  /* read form */
  if(dbg)printf("Form: "); fflush(stdout); scanf("%s", input);
  if(!strcmp(input, "ijk")) *form = ijk;
  else if(!strcmp(input, "ikj")) *form = ikj;
  else if(!strcmp(input, "kij")) *form = kij;
  else assert(0);
  /* read flag */
  if(dbg)printf("Flag: "); fflush(stdout); scanf("%s", input);
  /* read n */
  if(dbg)printf("N: "); fflush(stdout); scanf("%i", n);
  /* allocate memory for a and b */
  int t_n = pow(*n,2);
  *a_p = (int*) malloc(sizeof(int)*t_n);
  *b_p = (int*) malloc(sizeof(int)*t_n);
  /* initialize matricies for R */
  if(!strcmp(input, "R")) {
    srand(time(NULL));
    for (int i=0; i < t_n; i++) {
      (*a_p)[i] = rand() % 100;
      (*b_p)[i] = rand() % 100;
    }
  } else {
    /* initalize matricies for I */
    if(!strcmp(input, "I")) {
      for(int i = 0; i < t_n; i++) {
        scanf("%i", (*a_p)+i);
      }
      for(int i = 0; i < t_n; i++) {
        scanf("%i", (*b_p)+i);
      }
    }
  }
}

void Print_matrix(int * matrix_p, int n) {
  for(int i = 0; i < n; i++)
    printf("%i\t", matrix_p[i]);
  printf("\n");
}









