#include <fstream>
#include <string>

#include "example.pb.h"

int main(int argc, char **argv) {
  sample::Example example;
  example.set_foo(std::string{argv[1]});
  example.set_bar(atoi(argv[2]));
  {
    std::fstream output(argv[3],
                        std::ios::out | std::ios::trunc | std::ios::binary);
    example.SerializeToOstream(&output);
  }

  return 0;
}
