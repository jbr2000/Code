#ifndef WORLD_H
#define WORLD_H

#include <vector>
#include <iostream>
#include <bitset>
using namespace::std;

class World {
  public:
    World(int _width, vector<bitset<4> > _data);
    ~World();
    int width;
    vector<bitset<4> > data;
};

#endif
