{ stdenv
, jo
, bash
, pkg-config
, coreutils
, protobuf_25
, grpc
, clang
, fmt
, rustc
, busybox

  # for tests
, gnugrep
, unixtools
, python3
}:

stdenv.mkDerivation rec {
  name = "nix-dependencies";

  unpackPhase=''true'';

  nativeBuildInputs = [
    pkg-config
    protobuf_25
    grpc
    jo
    bash
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
          test=$(jo PATH=$(jo -a ${gnugrep}/bin ${unixtools.xxd}/bin ${python3}/bin)) \
          PKGCONFIG=$(jo pkg-config=${pkg-config}/bin/pkg-config \
                         PKG_CONFIG_PATH=$(jo -a $PKG_CONFIG_PATH)) \
          RUST=$(jo PATH=$(jo -a ${rustc}/bin ${clang}/bin ${coreutils}/bin \
                                 ${busybox}/bin)) \
          ) > config.json
    cat config.json
    jo "just files"=$(jo config=$(jo -a $(jo root=system path=$out/share/config.json))) > rc.json

    cat > withRc-just-mr <<EOF
    #!${bash}/bin/bash
    exec just-mr --rc $out/share/rc.json "\$@"
    EOF
  '';

  installPhase = ''
    mkdir -p $out/share $out/bin
    cp config.json $out/share
    cp rc.json $out/share
    cp withRc-just-mr $out/bin
    chmod 555 $out/bin/withRc-just-mr
  '';

}
