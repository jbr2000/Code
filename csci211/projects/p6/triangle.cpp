// McWilliams, Spencer
// smcwilliams
// triangle.cpp

#include <iostream>
using namespace std;

#include "triangle.h"
#include "shape.h"

Triangle::Triangle(int x, int y) : Shape(x,y) {
}

Triangle::~Triangle() {
}

void Triangle::draw(Grid &grid) {
// SC: out of grid range.
    if(m_x+4 > 59 || m_y+3 > 23)
        return;

    for (int row = m_y; row < m_y+3; row++) {
    // first row
        if (row == m_y) {
            for (int col = m_x; col < m_x+5; col++) {
                if (col == m_x+2)
                    grid.set(col,row,'+');
            }
        }
    // second row
        if (row == m_y+1) {
            for (int col = m_x; col < m_x+5; col++) {
                if (col == m_x+1 || col == m_x+3)
                    grid.set(col,row,'+');
            }
        }
    // final row
        if (row == m_y+2) {
            for (int col = m_x; col < m_x+5; col++) {
                grid.set(col,row,'+');
            }
        }
    }
    return;
}
