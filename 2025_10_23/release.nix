let
  pkgs = import <nixpkgs> {};
in
{
  nsystest = pkgs.testers.runNixOSTest ./nixos/test.nix;
}