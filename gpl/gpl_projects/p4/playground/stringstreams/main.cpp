#include <sstream>
#include <iostream>
using namespace std;

int main() {
  stringstream ss;
  ss << "hello\n";
  cout << ss.str();

  return 0;
}
