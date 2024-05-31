{ stdenv
, jo
, pkg-config
, coreutils
, protobuf_25
, grpc
, clang
, fmt

  # for tests
, gnugrep
, unixtools
}:

stdenv.mkDerivation rec {
  name = "nix-dependencies";

  unpackPhase=''true'';

  nativeBuildInputs = [
    pkg-config
    protobuf_25
    grpc
    jo
  ];

  buildInputs = [
    clang
    fmt
    coreutils
    gnugrep
    unixtools.xxd
  ];

  buildPhase = ''
    echo PKG_CONFIG_PATH=$PKG_CONFIG_PATH
    jo TOOLCHAIN_CONFIG=$(jo \
          CC=$(jo PATH=$(jo -a ${clang}/bin ${coreutils}/bin)) \
          PROTO=$(jo PATH=$(jo -a ${protobuf_25}/bin ${grpc}/bin) \
                     PROTOC=${protobuf_25}/bin/protoc \
                     GRPC_PLUGIN=${grpc}/bin/grpc_cpp_plugin \
             ) \
          shell=$(jo PATH=$(jo -a ${coreutils}/bin)) \
          test=$(jo PATH=$(jo -a ${gnugrep}/bin ${unixtools.xxd}/bin)) \
          PKGCONFIG=$(jo pkg-config=${pkg-config}/bin/pkg-config \
                         PKG_CONFIG_PATH=$(jo -a $PKG_CONFIG_PATH)) \
          ) > config.json
    cat config.json
    jo "just files"=$(jo config=$(jo -a $(jo root=system path=$out/share/config.json))) > rc.json
  '';

  installPhase = ''
    mkdir -p $out/share
    cp config.json $out/share
    cp rc.json $out/share
  '';

}
