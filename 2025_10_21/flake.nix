{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs?ref=nixos-21.11";
  };

  outputs = { self, nixpkgs, nixpkgs-old }: 
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
  in
  import ./proj/release.nix { inherit pkgs; };
}
