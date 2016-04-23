// McWilliams, Spener
// smcwilliams
// grid.cpp

#include <iostream>
using namespace std;

#include "grid.h"

Grid::Grid()
{
    for(int row=0; row<24; row++) {
        for(int col=0; col<60; col++) {
            m_grid[row][col] = ' ';
        }
    }
}

Grid::~Grid()
{

}

void Grid::print() {
    for(int row=0; row<24; row++) {
        for(int col=0; col<60; col++)
            cout << m_grid[row][col];
        cout << endl;
    }
}

void Grid::set(int x, int y, char input)
{
    if (x > 59)
        return;
    if (y > 23)
        return;
    m_grid[y][x] = input;
    return;
}
