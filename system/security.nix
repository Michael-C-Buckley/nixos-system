{ inputs, pkgs, lib,...}: {

  imports = [
    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    inputs.agenix.packages.x86_64-linux.default
  ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/home/michael/.ssh/id_ed25519"
    "/root/.ssh/id_ed25519"
  ];

  # WIP: Age not working on desktop
  # environment.etc."systemd/resolved.conf".source = config.age.secrets.dns.path;

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
    openssh.enable = lib.mkDefault true;
    vscode-server.enable = lib.mkDefault true;
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
