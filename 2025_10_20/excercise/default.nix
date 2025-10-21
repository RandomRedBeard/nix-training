/**
  Basic raw derivation with bash as a builder
  includes make ++ gcc
 */

let
  pkgs = import <nixpkgs> {};
in
derivation {
  name = "hello";
  src = ./mini-hello;
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./builder.sh ];
  system = builtins.currentSystem;
  PATH = "${pkgs.gcc}/bin:${pkgs.coreutils}/bin:${pkgs.gnumake}/bin";
}