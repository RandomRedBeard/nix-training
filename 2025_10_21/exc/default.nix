let
  pkgs = import <nixpkgs> {};
  env = {
    nativeBuildInputs = [pkgs.cowsay];
  };
in
pkgs.runCommand "cow" env ''
  find "${pkgs.cowsay}/share/cowsay/cows" \
  -name "*.cow" \
  -exec cowsay -f {} "Hello, Nix Users" >> $out \;
''