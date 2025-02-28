{pkgs, lib, ... }: let 
  wireguardInterface = {
    name,
    ipAddresses ? [],
  }: {
    description = "WireGuard: ${name}";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      # Agenix is currently not working on the desktop, workaround with local file until resolution
      ExecStartPre = [
        "${pkgs.iproute2}/bin/ip link add dev ${name} type wireguard"
        "${pkgs.iproute2}/bin/ip link set ${name} mtu 1420"
        # "${pkgs.wireguard-tools}/bin/wg setconf ${name} ${config.age.secrets."wg-${name}".path}"
        "${pkgs.wireguard-tools}/bin/wg setconf ${name} /etc/wireguard/wg-${name}.conf"
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
      ipAddresses = ["192.168.240.241/31"];
    };
  };
}