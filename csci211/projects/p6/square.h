// McWilliams, Spencer
// smcwilliams
// square.h

#ifndef SQUARE_H
#define SQUARE_H

#include "shape.h"

class Square : public Shape
{
    public:
        Square(int x, int y, int size);
        ~Square();
        void draw(Grid &grid);
    private:
        int m_size;
};

#endif
