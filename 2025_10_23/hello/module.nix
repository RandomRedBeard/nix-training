{ config, pkgs, lib, ... }:
let cfg = config.services.hello; in
{
  options.services.hello = {
    enable = lib.mkEnableOption "GNU-Helllo as a service";
    port = lib.mkOption {
      type = lib.types.port;
      default = 8081;
      description = "Port to listen on";
    };
    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Open firewall";
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.hello;
      description = "ur mom";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.hello = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = ''
        ${pkgs.socat}/bin/socat \
        TCP4-LISTEN:${builtins.toString cfg.port},reuseaddr,fork \
        EXEC:${cfg.package}/bin/hello
      '';
    };

    networking.firewall.allowedTCPPorts = (lib.mkIf cfg.openFirewall [ cfg.port]);

  };
}