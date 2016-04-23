// McWilliams, Spencer
// smcwilliams
// point.h

#include <iostream>
using namespace std;

#include "point.h"
#include "grid.h"

Point::Point(int x, int y, char c) : Shape(x,y) {
    m_char = c;
}

Point::~Point() {
}

void Point::draw(Grid &grid) {
// SC: out of grid range.
    if(m_x > 59 || m_y > 23)
        return;
    else
        grid.set(m_x,m_y,m_char);
    return;
}
