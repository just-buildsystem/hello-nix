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
    rev = "v1.3.1";
    sha256 = "sha256-kv7HpDEYZml5uk06s8Cxt5rEpxaJBz9s+or6Od1q4Io=";
  };

  srcrustrules = fetchFromGitHub {
    owner = "just-buildsystem";
    repo = "rules-rust";
    rev = "bf3e05a614f1de5a9a8a0f8e40f1dd9e1f6609da";
    sha256 = "sha256-8y10ZmZpeTGtbkIeneaVISyMbVKfIi3gHqyvztnKn0M=";
  };


  unpackPhase = ''
    cp $srcjust/bin/just-import-git.py .
    cp $srcrustrules/bin/hdump.py .
  '';

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp just-import-git.py $out/bin/just-import-git
    cp hdump.py $out/bin/hdump
    chmod 555 $out/bin/just-import-git $out/bin/hdump
  '';

}
