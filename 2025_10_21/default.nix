{
  pkgs ? import <nixpkgs> {},
  ...
}:
pkgs.stdenv.mkDerivation {
  name = "hello";
  src = builtins.fetchTarball {
    url = "http://gnu.mirror.constant.com/hello/hello-2.9.tar.gz";
    name = "hello";
  };
  # src = ./hello-2.9;
  doCheck = true;
}