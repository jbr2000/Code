// McWilliams, Spencer
// smcwilliams
// grid.h

#ifndef GRID_H
#define GRID_H

class Grid
{
    public:
        Grid();
        ~Grid();
        void print();
        void set(int x, int y, char input);
    protected:
        //const int MAX_ROW = 25;
        //const int MAX_COL = 61;
        char    m_grid[24][60];
};

#endif
