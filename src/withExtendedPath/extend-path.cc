#include <algorithm>
#include <cstdlib>
#include <string>
#include <unistd.h>
#include <vector>

int main(int argc, char* argv[]) {
  constexpr int kForkFailed = 65;
  constexpr int kPrerequisiteError = 97;
  auto kEnv = std::string{"/usr/bin/env"};

  if (argc < 3) {
    return kPrerequisiteError;
  }

  // compute PATH
  auto path = std::string{argv[1]};
  auto const* env_path = std::getenv("PATH");
  if (env_path && (*env_path != '\0')) {
    path = std::string{env_path} + std::string{":"} + path;
  }
  auto path_arg = std::string{"PATH="} + path;

  // create new argument vector
  std::vector<char*> nargv{};
  nargv.reserve(argc+3);
  nargv.push_back(kEnv.data());
  nargv.push_back(path_arg.data());
  for (int i=2; i < argc; i++) {
    nargv.push_back(argv[i]);
  }
  nargv.push_back(nullptr);

  // exec
  (void) execvp(nargv[0], static_cast<char* const*>(nargv.data()));
  return kForkFailed;
}
