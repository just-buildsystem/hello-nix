#include <fstream>
#include <iostream>

#include "example.pb.h"

int main(int argc, char **argv) {
  sample::Example example;

  {
    std::fstream input(argv[1], std::ios::in | std::ios::binary);
    example.ParseFromIstream(&input);
  }

  std::cout << "foo=" << example.foo() << "\n";
  std::cout << "bar=" << example.bar() << std::endl;

  return 0;
}
