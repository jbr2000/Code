#include "matrix.h"
#include "world.h"
#include <iostream>
#include <vector>
#include <fstream>
#include <cassert>
#include <bitset>
#include <stdlib.h>
#include <string.h>
#include <math.h>
using namespace::std;

#define dbg 0

World* initialize_world(char* _inputfilename);
Matrix* initialize_transitivity_matrix_for(World* _world);
Matrix* initialize_joint_prediction_matrix_for(World* _world);
Matrix* initialize_observation_probabillity_matrix_for(bitset<4> _observation, World* _world, float _d[]);
void determine_most_likely_state(Matrix* _y, int _world_width);
vector<bitset<4> > vectorize_observations(int argc, char* argv[]);

/* Desc: Given the first line of the input for the world, determine it's width
   Args: str = string representing one row of the world
   Retn: integer of the worlds length.  */ 
int determine_world_width(char _str[256]);

/* Desc: Given a line of input, add the values to the world vector.
   Args: str = string representing one row of the world
   Retn: Void  */ 
void push_line(char _str[256], vector<bitset<4> >* _vec);

/* Desc: Create sensory error table given cmd line
   Args: _str = string to command line argument
         _array = pointer to array in main
   Retn: Void  */ 
void initialize_sensory_error_table(char _str[256], float _array[]);







int main(int argc, char *argv[]) {
  //assert(argc >= 5);

  // store all observations in vector
  vector<bitset<4> > observations = vectorize_observations(argc, argv);

  // create sensory error table
  float d[5];
  initialize_sensory_error_table(argv[2], d);

  // create world
  World* world = initialize_world(argv[1]);

  // create initial transitivity matrix
  Matrix* T = initialize_transitivity_matrix_for(world);

  // initalize joint prediction matrix
  Matrix* J = initialize_joint_prediction_matrix_for(world); 
  J = T->multiply_by(J);

  Matrix* Y;
  for(unsigned int i=0; i<observations.size(); i++) {
    if(dbg) cout << "\n\nIteration: " << i << endl;
    Matrix* O = initialize_observation_probabillity_matrix_for(observations[i], world, d);
    Y = O->multiply_by(J);
    J = T->multiply_by(Y);
  }
  determine_most_likely_state(Y, world->width);

  return 0;
}




World* initialize_world(char* _inputfilename) {
  if(dbg) cout << "Initalizing world...\n";
  // open the input file
  ifstream inputfile;
  inputfile.open(_inputfilename);
  assert(inputfile.is_open());  
  // initialize variables
  char str[256];
  int world_width = 0;
  vector<bitset<4> > tmpdata;

  // initialize world_w given one line of input
  inputfile.getline(str, 256);
  world_width = determine_world_width(str);

  // populate world
  inputfile.seekg(0, ios_base::beg); //reset input file
  while(inputfile) {
    if(!inputfile.getline(str, 256)) break;
    push_line(str, &tmpdata);
  }

  if(dbg) {
    cout << "world_w: " << world_width << endl;
    cout << "world size: " << tmpdata.size() << endl;
  }

  World* tmpworld = new World(world_width, tmpdata);

  inputfile.close();
  return tmpworld;
}

void push_line(char _str[256], vector<bitset<4> >* _vec) {
  char *token;
  token = strtok(_str," \n");
  while(token != NULL) {
    bitset<4> tmpset (atoi(token));
    if(dbg) cout << tmpset << " ";
    _vec->push_back(tmpset);
    token = strtok(NULL, " \n");
  }
  if(dbg) cout << endl;
}

int determine_world_width(char _str[256]) {
  char *token;
  vector<char*> tmp;
  token = strtok(_str," \n");
  while(token != NULL) {
    tmp.push_back(token);
    token = strtok(NULL," \n");
  }
  return tmp.size();
}

Matrix* initialize_transitivity_matrix_for(World* _world) {
  if(dbg) cout << "Initializeing transitivity matrix...\n";
  // crete empty matrix
  vector<float> transmatrix;
  if(dbg) cout << "world size: " << _world->data.size() << endl;
  for(int i=0; i<pow(_world->data.size(), 2); i++) {
    transmatrix.push_back(0);
  }

  // populate matrix
  if(dbg) cout << "Populating transitivity matrix...\n";
  // width of the world
  int t_width = _world->data.size();
  // width of the tranitivity matrix
  int w_width = _world->width;
  float transprob = 0.0; /* transition probability */
  if(dbg) cout << "transitivity table width: " << t_width << "\n world width: " << w_width << endl;
  for(int i=0; i<t_width; i++) {
    bitset<4> tmpset = _world->data[i];
    if(tmpset.count() < 4) transprob = (1.0/(float(4-tmpset.count())));
    else transprob = 0;
    if(dbg) cout << "i: " << i << " bitset: " << tmpset << " prob: " << transprob << endl;
    // east 
    if(!tmpset[0]) {
      transmatrix[((i+1)*t_width)+i] = transprob;
      if(dbg)cout << "setting [" << ((i+1)*t_width)+i << "] to: " << transprob << endl;
    }
    // west
    if(!tmpset[1]) {
      transmatrix[((i-1)*t_width)+i] = transprob;
      if(dbg)cout << "setting [" << ((i-1)*t_width)+i << "] to: " << transprob << endl;
    }
    // south
    if(!tmpset[2]) {
      transmatrix[((i+w_width)*t_width)+i] = transprob;
      if(dbg)cout << "setting [" << ((i+w_width)*t_width)+i  << "] to: " << transprob << endl;
    }
    // north
    if(!tmpset[3]) {
      transmatrix[((i-w_width)*t_width)+i] = transprob;
      if(dbg)cout << "setting [" << ((i-w_width)*t_width)+i << "] to: " << transprob << endl;
    }
  }
  Matrix* tmp = new Matrix(_world->data.size(), transmatrix);
  if(dbg) { cout << "Printing Transitivity matrix...\n"; tmp->print(); }
  return tmp;
}

Matrix* initialize_joint_prediction_matrix_for(World* _world) {
  float i = 0;
  vector<float> tmpdata;

  // count how many accessible states exist
  for(unsigned int j=0; j<_world->data.size(); j++) {
    if(_world->data[j].to_ulong() != 15) i++;
  }

  // determine ratio of accessible:total stats
  float ratio = 1/i;
  for(unsigned int j=0; j<_world->data.size(); j++) {
    if(_world->data[j].to_ulong() != 15) {
      tmpdata.push_back(ratio);
    } else {
      tmpdata.push_back(0);
    }
  }

  Matrix *tmpmatrix = new Matrix(1, tmpdata);
  if(dbg) { cout << "Printing J...\n"; tmpmatrix->print();}
  return tmpmatrix;
}

void initialize_sensory_error_table(char _str[256], float _array[]) {
  float se = atof(_str);
  if(dbg) cout << "sensory error: " << se << endl;
  for(int i=0; i<5; i++) {
    _array[i] = pow(se,i) * pow(1-se,4-i);
    if(dbg) cout << "d[" << i << "]: " << _array[i] << endl;
  }
}

Matrix* initialize_observation_probabillity_matrix_for(bitset<4> _observation, World* _world, float _d[]) {
  vector<float> tmp_data;
  for(unsigned int i=0; i<pow(_world->data.size(),2); i++) {
    tmp_data.push_back(0);
  }
  for(unsigned int i=0; i<_world->data.size(); i++) {
    bitset<4> obs_xor = _world->data[i]^_observation;
    if(dbg) cout << "Initializing O for: " << i << " -> " << _d[obs_xor.count()] << endl;
    tmp_data[i+(i*_world->data.size())] = _d[obs_xor.count()];
  }
  if(dbg) {
    Matrix* test = new Matrix(_world->data.size(), tmp_data);
    test->print();
  }
  return new Matrix(_world->data.size(), tmp_data);
}

vector<bitset<4> > vectorize_observations(int argc, char* argv[]) {
  vector<char*> observation_arguments;
  vector<bitset<4> > tmp_observations;
  bitset<4> tmp_set;

  // create vector for observations
  for(int i=0; i<argc-3; i++) {
    observation_arguments.push_back(argv[i+3]);
    if(dbg) cout << "Pushing observation: " << argv[i+3] << endl;
  }

  // for each obeservation
  for(unsigned int i=0; i<observation_arguments.size(); i++) {
    // clear bitset
    tmp_set.reset();
    // copy into buffer
    char* buffer = (char*)malloc(5);
    strcpy(buffer,observation_arguments[i]);
    // set bits
    for(int j=0; j<5; j++) {
      if(buffer[j] == '0') tmp_set.reset();
      if(buffer[j] == 'N') tmp_set.set(3,1);
      if(buffer[j] == 'S') tmp_set.set(2,1);
      if(buffer[j] == 'W') tmp_set.set(1,1);
      if(buffer[j] == 'E') tmp_set.set(0,1);
    }
    tmp_observations.push_back(tmp_set);
    if(dbg) cout << "Vectorizing: " << buffer << " -> " << tmp_set << endl;
  }

  return tmp_observations;
}

void determine_most_likely_state(Matrix* _y, int _world_width) {
  assert(_y->get_width() == 1);
  float sum = 0.0;
  float cur_max = 0.0;
  vector<int> most_likely_states;
  vector<float> normalized_values;

  if(dbg) { cout << "\nEstimating state given Y:\n"; _y->print(); }
  // calculate sum
  for(int i=0; i<_y->get_size(); i++)
    sum += _y->get_value_at(i,0);
  if(dbg) cout << "Sum for Y: " << sum << endl;
  // normalize values
  for(int i=0; i<_y->get_size(); i++) {
    normalized_values.push_back(_y->get_value_at(i,0) / sum);
    if(dbg) cout << "normal: " << (_y->get_value_at(i,0) / sum) << endl;
  }
  // determine max
  for(unsigned int i=0; i<normalized_values.size(); i++)
    if(normalized_values[i] > cur_max) cur_max = normalized_values[i];

  // determine states
  for(unsigned int i=0; i<normalized_values.size(); i++)
    if(normalized_values[i] == cur_max) most_likely_states.push_back(i);

  if(dbg) cout << "Most likely states:\n";
  for(unsigned int i=0; i<most_likely_states.size(); i++) {
    int state = most_likely_states[i];
    cout << "(" << state/_world_width << ", " << state%_world_width << ") " << cur_max << endl;
  }
}




















