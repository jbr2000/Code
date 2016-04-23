// McWilliams, Spencer
// smcwilliams
// square.cpp

#include <iostream>
using namespace std;

#include "grid.h"
#include "square.h"

Square::Square(int x, int y, int size) : Shape(x,y)
{
    m_size = size;
}

Square::~Square() {
}

void Square::draw(Grid &grid) {
// SC: out of grid range.
    if (m_x > 60 || m_y > 24)
        return;
    for (int row = m_y; (row < 24 && row < m_y+m_size); row++) {
        // if we are on the first row or last row
        if (row == m_y || row == m_y+m_size-1) {
            for (int col = m_x; (col < 60 && col < m_x+m_size); col++)
                grid.set(col,row,'*');
        }
        // other wise we are on a middle row
        else {
            grid.set(m_x,row,'*');
            if (m_x+m_size-1 < 60)
                grid.set(m_x+m_size-1,row,'*');
        }
    }
    return;
}
