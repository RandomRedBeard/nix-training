let
  pkgs = import <nixpkgs> {};
in
derivation {
  name = "mydrv";
  builder = "${pkgs.bashInteractive}/bin/bash";
  args = [ ./builder.sh ];
  system = builtins.currentSystem;
  PATH = "${pkgs.coreutils}/bin";
}