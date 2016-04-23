#include "matrix.h"
#define dbg 0

Matrix::Matrix(int w, vector<float> indata) {
  width = w;
  data = indata;
}

Matrix::~Matrix() {
}

int Matrix::get_width() {
  return width;
}

int Matrix::get_size() {
  return data.size();
}

float Matrix::get_value_at(int i, int j) {
  return data[j+(i*this->get_width())];
}

void Matrix::print() {
  if(dbg) cout << "Printing Matrix...\n";
  for(int i=0; i<this->get_size(); i++) {
    cout << setprecision(2) << this->data[i] << "  ";
    if((i>= width-1) && (i%width == (width-1))) cout << endl;
  }
  return;
}



Matrix* Matrix::multiply_by(Matrix *_m2) {
  // width is referring to the current matrix's width
  //assert(this->get_width() == (_m2->get_size()/_m2->get_width()));
  if(dbg) {
    cout << "Multiplying matricies...\n";
    cout << "Matrix 1:\n";
    this->print();
    cout << "Matrix 2:\n";
    _m2->print();
  }
  vector<float> tmpdata;

  for(int i=0; i<this->get_size()/this->get_width(); i++) {
    float tmpval = 0;
    for(int j=0; j<width; j++) {
      //tmpdata.push_back( (this->get_value_at(i+(j*width))) * _m2->get_value_at(i) );
      tmpval += (this->get_value_at(i,j) * _m2->get_value_at(j,0));
    }
    tmpdata.push_back(tmpval);
  }

  Matrix* mtr = new Matrix(_m2->get_width(), tmpdata);
  if(dbg) {
    cout << "Resultimg Matrix:\n";
    mtr->print();
  }

  return mtr;
}
