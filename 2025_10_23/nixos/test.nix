# While working on this task, keep the NixOS Integration Test Driver
# documentation in a browser tab:
#
# https://nixos.org/manual/nixos/stable/index.html#sec-nixos-tests

{
  name = "GNU Hello Test";

  # We can set defaults that are applied to all machines
  defaults = {
    #networking.firewall.enable = false;
  };

  nodes = {
    machine = { pkgs, lib, ... }: {
      # This attribute set is a normal NixOS configuration that does not know
      # that it is part of a test. Firewall, service configs, etc.

      imports = [
        ./.
      ];
    };
    client = { pkgs, lib, ...}: {
      imports = [];
      environment.systemPackages = with pkgs; [
        busybox
      ]; 
    };
  };

  testScript = { nodes, ... }:
  let
    port = builtins.toString nodes.machine.services.hello.port;
  in ''
    start_all()

    # The VM from above is available as object `machine`, because that is its
    # name in the `nodes` attribute set.
    machine.wait_for_unit("hello.service")
    machine.wait_for_open_port(${port})

    # Prevent ping attempt before vm is ready
    client.wait_for_unit("backdoor.service")

    # The NixOS Integration Test Driver Documentation (which you hopefully
    # keep open in a browser tab) tells you which Python object methods are
    # available for your testing needs

    client.succeed("ping -c 1 machine")

    output = client.succeed("nc machine ${port} -w 1")
    assert "Hello, world!" in output, output
  '';
}
