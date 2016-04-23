// McWilliams, Spencer
// smcwilliams
// point.h

#ifndef POINT_H
#define POINT_H

#include "shape.h"

class Point : public Shape
{
    public:
        Point(int x, int y, char c);
        ~Point();
        void draw(Grid &grid);
    private:
        char m_char;

};

#endif
