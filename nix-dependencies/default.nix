{ nixpkgs ? import <nixpkgs> {} }:
nixpkgs.callPackage ./dependencies.nix {}
