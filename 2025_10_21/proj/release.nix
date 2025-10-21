{
  pkgs ? import <nixpkgs> {},
  ...
}:
let
  default = pkgs.callPackage ./a {};
  wclang = pkgs.lib.callPackageWith {stdenv=(pkgs.overrideCC pkgs.stdenv pkgs.clangStdenv.cc);};
in
{
  inherit default;
  hello-clang = default.override {stdenv=pkgs.clangStdenv;};
  hello-patched = default.overrideAttrs (oldAttrs: {patches = (oldAttrs.patches or []) ++ [./my.patch] ;});
  hello-clang-2 = default.override {stdenv = (pkgs.overrideCC pkgs.stdenv pkgs.clangStdenv.cc);};
}