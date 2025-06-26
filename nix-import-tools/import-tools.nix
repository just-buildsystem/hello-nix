{ stdenv
, fetchFromGitHub
, python3
}:

stdenv.mkDerivation rec {
  name = "just-import-tools";
  version = "2024-06-25";

  buildInputs = [ (python3.withPackages (ps: [])) ];

  srcjust = fetchFromGitHub {
    owner = "just-buildsystem";
    repo = "justbuild";
    rev = "v1.6.0-beta1";
    sha256 = "sha256-HEM7f8P8lHOFrv5eRTtMeEKgyxHlZ1uFn5K86Az/csU=";
  };

  srcrustrules = fetchFromGitHub {
    owner = "just-buildsystem";
    repo = "rules-rust";
    rev = "8ce86a09143d173e331ac7c9c79bddf26c97966d";
    sha256 = "sha256-S3W8S106CNVgpHAGAgnlrALxDr5FjwnwbS2uBmq3duY=";
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
