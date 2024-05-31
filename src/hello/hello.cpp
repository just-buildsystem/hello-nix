#include <iostream>

#include <fmt/format.h>
#include <string>

int main(int argc, char **argv) {
  std::cout << fmt::format("Hello {}!",
                           argc > 1 ? std::string{argv[1]} : "World")
            << std::endl;
  return 0;
}
