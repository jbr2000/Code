/*
  Knapsack.cpp
  Spencer McWilliams
  smcwilliams3
*/

#define dbg 0

#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;
#include <stdio.h>

int main() {
  int num_items,
      knapsack_capacity;
  vector < int > path;
  vector < int > values;
  vector < int > weights;
  vector < vector < int > > results;
  vector < vector < int > > backtrack;


  cin >> num_items >> knapsack_capacity;

  // populate values, weights
  // initialize backtracking, results
  for (int i=0; i<num_items; i++) {
    int val;
    cin >> val;
    values.push_back(val);
  }
  for (int i=0; i<num_items; i++) {
    int val;
    cin >> val;
    weights.push_back(val);
  }
  for (int i=0; i<num_items; i++) {
    vector < int > empty (knapsack_capacity+1, 0);
    results.push_back(empty);
    backtrack.push_back(empty);
  }
  if(dbg)printf("restults and backtrack: %i x %i\n", num_items, knapsack_capacity+1);

  for (int n=0; n<num_items; n++) {
    int item[2] = {values[n], weights[n]};
    if(dbg)printf("Item:\t%i\tvalue: %i\tweight: %i\n", n, item[0],item[1]);
    for (int c=1; c<=knapsack_capacity; c++) {
      int remaining_weight = c - item[1];
      if(dbg)printf("\tWeight: %i\tRemaing: %i\n", c, remaining_weight);
      if ( remaining_weight >= 0 ) { // taking item
        if ( n > 0 ) {
          if ( results[n-1][c] > item[0]+results[n-1][remaining_weight] ) {
            results[n][c] = results[n-1][c];
            backtrack[n][c] = c;
          } else { // taking is higher than previous 
            results[n][c] = item[0]+results[n-1][remaining_weight];
            backtrack[n][c] = remaining_weight;
          }
        } else results[n][c] = item[0]; // n == 0
        if(dbg)printf("\t\tT: %i!\n", results[n][c]);
      } else { // not taking item
        results[n][c] = ((n==0)? 0 : results[n-1][c]);
        backtrack[n][c] = c;
        if(dbg)printf("\t\tX: %i\n", results[n][c]);
      }
      if(dbg)printf("\t\tBack: %i\n", backtrack[n][c]);
    }
  }
  printf("%i\n", results[num_items-1][knapsack_capacity]);

  int c = knapsack_capacity;
  for ( int i = num_items-1; i >= 0; i-- ) {
    if ( backtrack[i][c] < c )
      path.push_back(i+1);
    c = backtrack[i][c];
  }

  reverse(path.begin(), path.end());
  for ( vector < int >::iterator it = path.begin(); it != path.end(); ++it) {
    printf("%i ", *it);
  }
  cout << endl; 

  return 0;
}




















