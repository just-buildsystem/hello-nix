{ stdenv
, fetchFromGitHub
, python3
}:

stdenv.mkDerivation rec {
  name = "just-import-tools";
  version = "2026-01-03";

  buildInputs = [ (python3.withPackages (ps: [])) ];

  srcjust = fetchFromGitHub {
    owner = "just-buildsystem";
    repo = "justbuild";
    rev = "v1.6.3";
    sha256 = "sha256-ZTwe6S0AH1yQt5mABtIeWuMbiVSKeOZWMFI26fthLsM=";
  };

  srcrustrules = fetchFromGitHub {
    owner = "just-buildsystem";
    repo = "rules-rust";
    rev = "86601e04b088c973efc62f03d9733fd6d3827241";
    sha256 = "sha256-84VaDU6YHZtf4hR7pJ1Wt2kPo6qJFvDqwe5nRJHGxxE=";
  };


  unpackPhase = ''
    cp $srcjust/bin/just-import-git.py .
    cp $srcjust/bin/just-deduplicate-repos.py .
    cp $srcrustrules/bin/hdump.py .
    cp $srcrustrules/bin/just-import-cargo.py .
  '';

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp just-import-git.py $out/bin/just-import-git
    cp just-deduplicate-repos.py $out/bin/just-deduplicate-repos
    cp hdump.py $out/bin/hdump
    cp just-import-cargo.py $out/bin/just-import-cargo
    chmod 555 $out/bin/just-import-git $out/bin/just-deduplicate-repos
    chmod 555 $out/bin/hdump $out/bin/just-import-cargo
  '';

}
