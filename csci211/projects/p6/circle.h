// McWilliams, Spencer
// smcwilliams
// triangle.h

#ifndef CIRCLE_H
#define CIRCLE_H

#include "shape.h"

class Circle : public Shape
{
    public:
        Circle(int x, int y);
        ~Circle();
        void draw(Grid &grid);
};

#endif
