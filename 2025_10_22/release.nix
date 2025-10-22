let
  pkgs_src = <nixpkgs>;
  overlay = import ./nix/overlay.nix;
in
{
  packages = import pkgs_src {
    overlays = [ overlay ];
  };
}