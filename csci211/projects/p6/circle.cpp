// McWilliams, Spencer
// smcwilliams
// circle.cpp

#include <iostream>
using namespace std;

#include "grid.h"
#include "circle.h"

Circle::Circle(int x, int y) : Shape(x,y) {
}

Circle::~Circle() {
}

void Circle::draw(Grid &grid) {
// SC: out of grid range.
    if (m_x > 60 || m_y > 24)
        return;

    for (int row = m_y; (row < 24) && (row < m_y+4); row ++) {
        // if we are on the first row or last row
        if (row == m_y || row == m_y+3) {
            for (int col = m_x; (col < 60 && col < m_x+3); col++) {
                // if column is one of the middle two columns
                if ((col == m_x+1) || (col == m_x+2))
                    grid.set(col,row,'o');
            }
        }
        else {
            grid.set(m_x,row,'o');
            if (m_x+3 < 60)
                grid.set(m_x+3,row,'o');
        }
    }
    return;
}
