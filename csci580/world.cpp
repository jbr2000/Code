#include "world.h"

World::World(int _width, vector<bitset<4> > _data) {
  data = _data;
  width = _width;
}
World::~World() {
}
