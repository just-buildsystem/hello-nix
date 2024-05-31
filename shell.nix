let

  sources = import ./nix/sources.nix;

  nixpkgs = sources."nixpkgs-unstable";

  pkgs = import nixpkgs {};

  nix-dependencies = import ./nix-dependencies { nixpkgs = pkgs; } ;

in pkgs.mkShell rec {

  name = "hello-nix";

  buildInputs = with pkgs; [
     niv
  ];

  shellHook = ''
     alias just-mr="just-mr --rc ${nix-dependencies}/share/rc.json"
  '';

}
