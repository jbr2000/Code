#ifndef MATRIX_H
#define MATRIX_H

#include <iostream>
#include <vector>
#include <bitset>
#include <iomanip>
#include <cassert>
using namespace::std;

class Matrix {
    public:
        Matrix(int w, vector<float> indata);
        ~Matrix();
        int get_width();
        int get_size();
        float get_value_at(int i, int j);
        void print();

        Matrix* multiply_by(Matrix *_m2data);

    private:
        vector<float> data;
        int width;
};

#endif
