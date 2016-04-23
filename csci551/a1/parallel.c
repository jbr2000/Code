/* File:     parallel.c
 * Purpose:  Use MPI to implement a parallel version of the trapezoidal 
 *           rule.  This version uses collective communications and
 *           MPI derived datatypes to distribute the input data and 
 *           compute the global sum.
 *
 * Input:    The endpoints of the interval of integration and the number
 *           of trapezoids
 * Output:   Estimate of the integral from a to b of f(x)
 *           using the trapezoidal rule and n trapezoids.
 *
 * Compile:  mpicc -g -Wall -o parallel parallel.c -lm
 * Run:      mpiexec -n <number of processes> ./integral
 *
 * Algorithm:
 *    1.  Each process calculates "its" interval of
 *        integration.
 *    2.  Each process estimates the integral of f(x)
 *        over its interval using the trapezoidal rule.
 *    3a. Each process != 0 sends its integral to 0.
 *    3b. Process 0 sums the calculations received from
 *        the individual processes and prints the result.
 *
 * Note:  foo(x) is all hardwired.
 */

// for input and output
#include <stdio.h>
// trig functions
#include <stdlib.h>
// fabs
#include <math.h>
// mpi functions
#include <mpi.h>

// Function to integrate
double Foo(double x);
// Calculate estimate for trapezoidal calculation
double Trap(double a, double b, int n);
// Get the gosh-darn input
void Get_input(int rank, double* a, double* b, int* n);
// Create an mpi type
void Create_mpi_type(double* a, double* b, int* n, MPI_Datatype* return_value);
// calculate the relative true error agin
double Relative_true_error(double approx_value);

const double TRUE_VALUE = 4003.72090015132683;
const double ACCEPTABLE_ERROR = 0.000000000000005;

int main() {
  double a, b, h, local_a, local_b, local_integral, total_integral;
  int comm_size, my_rank, n, local_n;
  double local_start, local_finish, local_elapsed, elapsed;

  // Start MPI
  MPI_Init(NULL, NULL);
  // number of processes
  MPI_Comm_size(MPI_COMM_WORLD, &comm_size);
  // get my rank
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
  // get input
  Get_input(my_rank, &a, &b, &n);
  // block to start timing
  MPI_Barrier(MPI_COMM_WORLD);
  // start timer
  local_start = MPI_Wtime();

  // set local variables
  h = (b-a)/n;
  local_n = n/comm_size;
  local_a = a + my_rank * local_n * h;
  local_b = local_a + local_n * h;
  // calculate local integral
  local_integral = Trap(local_a, local_b, local_n);

  // sum all local integrals
  MPI_Reduce(&local_integral, &total_integral, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

  local_finish = MPI_Wtime();
  local_elapsed = local_finish - local_start;
  MPI_Reduce(&local_elapsed, &elapsed, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);

  // print from process 0 after sum
  if (my_rank == 0) {
    printf("\nRunning on %i cores.\n", comm_size);
    printf("Elapsed time = %e seconds.\n", elapsed);
    printf("With n = %i trapezoids, our estimate\nof the integral from %.6f to %.6f = %.13e\n", n, a, b, total_integral);
    printf("true value = %.19e\n", TRUE_VALUE);
    double rte = Relative_true_error(total_integral); printf("absolute relative true error = %.19e\nis ", rte);
    if (rte > ACCEPTABLE_ERROR)
      printf("NOT ");
    printf("less than criteria = %.19e\n", ACCEPTABLE_ERROR);
  }

  // shut down MPI
  MPI_Finalize();

  return 0;
}




/* ..:: Custom Functions ::..  */

/* Fxn:    Foo
 * Input:  x: x to calculate for
 * Output: y value for given x
*/
double Foo(double x) {
  return (cos(x/3)-(2*cos(x/5))+(5*sin(x/4))+8);
}

/* Fxn:    Foo
 * Desc:   Calculate trapezodial estimation
 * Input:  a: starting x
 *         b: ending x
 *         n: number of trapezoids
 * Output: value of estimation
*/
double Trap(double a, double b, int n) {
  double h = (b-a)/n;
  double approx_value = (Foo(a) + Foo(b))/2.0;
  for (int i=1; i < n; i++) {
    double x_i = a + (i*h);
    approx_value += Foo(x_i);
  }
  approx_value = h*approx_value;
  return approx_value;
}

/*
 * Desc:   Get input
 * Input:  rank: rank of current process
 *         a: starting x
 *         b: ending x
 *         n: number of trapezoids
 * Output: Broadcast all inputs to all processes
*/
void Get_input(int rank, double* a, double* b, int* n) {
  MPI_Datatype input_datastructure;
  Create_mpi_type(a, b, n, &input_datastructure);
  if (rank == 0) {
    printf("Enter a, b, and n\n");
    scanf("%lf %lf %d", a, b, n);
  }
  /* broadcast our new datatype starting at address of a
   * b and n will be set because our datatype contains
   * offsets and values for them.  */
  MPI_Bcast(a, 1, input_datastructure, 0, MPI_COMM_WORLD);
  MPI_Type_free(&input_datastructure);
}

/*
 * Func:    Create_mpi_type
 * Desc:    Create mpi data type used to broadcast input
 * Input:   a: starting x
            b: ending x
            n: number of traps
 * Output: return_value: Datatype containing a, b, and n
*/
void Create_mpi_type(double* a, double* b, int* n, MPI_Datatype* return_value) {
  int           count = 3;
  int           array_of_blocklengths[3] = {1,1,1};
  MPI_Datatype  array_of_types[3] = {MPI_DOUBLE, MPI_DOUBLE, MPI_INT};
  MPI_Aint      array_of_displacements[3];
  MPI_Aint      a_addr, b_addr, n_addr;
  MPI_Get_address(a, &a_addr);
  MPI_Get_address(b, &b_addr);
  MPI_Get_address(n, &n_addr);
  array_of_displacements[0] = 0;
  array_of_displacements[1] = b_addr - a_addr;
  array_of_displacements[2] = n_addr - a_addr;

  MPI_Type_create_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, return_value);
  MPI_Type_commit(return_value);
}


/*------------------------------------------------------------------
 * Function:     rel_true_error
 * Purpose:      calculate relative true error given an approx. val
 * Input args:   approxValue: approximate value to calculate for
 * Output:       relative true error
*/
double Relative_true_error(double approx_value) {
  double true_error = TRUE_VALUE-approx_value;
  double relative_true_error = true_error/TRUE_VALUE;
  return fabs(relative_true_error);
}













