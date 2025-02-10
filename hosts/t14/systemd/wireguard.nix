{config, pkgs, lib, ... }: let 
  wireguardInterface = {
    name,
    ipAddresses ? [],
  }: {
    description = "WireGuard: ${name}";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStartPre = [
        "${pkgs.iproute2}/bin/ip link add dev ${name} type wireguard"
        "${pkgs.iproute2}/bin/ip link set ${name} mtu 1420"
        "${pkgs.wireguard-tools}/bin/wg setconf ${name} ${config.age.secrets."wg-${name}".path}"
      ] ++ lib.concatMap (addr: [
        "${pkgs.iproute2}/bin/ip address add ${addr} dev ${name}"
      ])
      ipAddresses;
      
      ExecStart = "${pkgs.iproute2}/bin/ip link set ${name} up";

      ExecStop = "${pkgs.iproute2}/bin/ip link delete ${name}";
      OnFailure = "${pkgs.iproute2}/bin/ip link delete ${name}";
    };
  };
in {
  systemd.services = {
    "wireguard-cary4" = wireguardInterface {
      name = "cary4";
      ipAddresses = ["192.168.78.2/27"];
    };
    "wireguard-creekstoneM4" = wireguardInterface {
      name = "creekstoneM4";
      ipAddresses = ["192.168.62.2/27"];
    };
  };
}