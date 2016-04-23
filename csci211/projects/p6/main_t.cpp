/***
    main() program for the 211 drawing program (p6)

    Reads in shape descriptions such as the following

            rectangle 10 10 4

    and instantiates the appropriate shape object 
    
    After all the input has been read, all the shapes are drawn into the
    grid and the Grid is drawn.

***/

#include <iostream>
#include <vector>
using namespace std;

#include "shape.h"
#include "triangle.h"
#include "circle.h"
#include "square.h"
#include "point.h"
#include "grid.h"

int main() {
    Grid grid;
    Point my_shape(2,3,'?');
    my_shape.draw(grid);
    grid.print();
    return 0;
}
