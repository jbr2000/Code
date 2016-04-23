// McWilliams, Spencer
// smcwilliams
// triangle.h

#ifndef TRIANGLE_H
#define TRIANGLE_H

#include "shape.h"

class Triangle : public Shape
{
    public:
        Triangle(int x, int y);
        ~Triangle();
        void draw(Grid &grid); 
};

#endif
