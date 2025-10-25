{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../hello/module.nix
  ];

  environment.systemPackages = with pkgs; [
    libcamera
    wireguard-tools
    busybox
  ];

  networking.firewall.enable = true;

  services.hello.enable = true;
  services.hello.openFirewall = true;

}
