// McWilliams, Spencer
// smcwilliams
// shapes.h

#ifndef SHAPES_H
#define SHAPES_H

#include "grid.h"

class Shape
{
    public:
        Shape(int x, int y);
        ~Shape();
        virtual void draw(Grid &grid) = 0;
    protected:
        int m_x;
        int m_y;
};

#endif
