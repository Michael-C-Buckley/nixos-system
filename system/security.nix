{ config, inputs, lib,...}: let
  inherit (lib) mkDefault mkForce;
in {

  imports = [
    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = [
    inputs.agenix.packages.x86_64-linux.default
  ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/home/michael/.ssh/id_ed25519"
    "/root/.ssh/id_ed25519"
  ];

  # WIP: Age not working on desktop
  # services.resolved.enable = true;
  environment.etc."systemd/resolved.conf".source = mkForce config.age.secrets.dns.path;

  security = {
    rtkit.enable = true;
    sudo = {
      extraConfig = "Defaults lecture=never";
      wheelNeedsPassword = lib.mkDefault false;
    };
  };

  # Revoke printing for its flaws over the years
  services = {
    printing.enable = false;
    openssh.enable = mkDefault true;
    vscode-server.enable = mkDefault true;
  };

  networking = {
    nftables.enable = true;
    firewall = {
      enable = true;
      allowPing =  true;
      allowedTCPPorts = [22 53 179];
      allowedUDPPorts = [53 51820];
    };
  };
}
