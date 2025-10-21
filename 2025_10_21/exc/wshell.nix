{
  pkgs ? import <nixpkgs> {},
  ...
}:
pkgs.writeShellApplication {
  name = "show-nixos-org";
  runtimeInputs = with pkgs; [ curl w3m ];
  text = ''
      echo hello
  '';
}