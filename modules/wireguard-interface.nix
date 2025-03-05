# This contains a function to produce a Wireguard Systemd Unit
{config, pkgs, lib, ... }: {
  name,
  cfgPath ? config.age.secrets."wg-${name}".path,
  ipAddresses ? [],
  mtu ? 1420,
}: {
  description = "WireGuard: ${name}";
  wantedBy = ["multi-user.target"];
  serviceConfig = {
    Type = "oneshot";
    RemainAfterExit = true;
    ExecStartPre = [
      "${pkgs.iproute2}/bin/ip link add dev ${name} type wireguard"
      "${pkgs.iproute2}/bin/ip link set ${name} mtu ${toString mtu}"
      # "${pkgs.wireguard-tools}/bin/wg setconf ${name} ${config.age.secrets."wg-${name}".path}"
      "${pkgs.wireguard-tools}/bin/wg setconf ${name} ${cfgPath}"
    ] ++ lib.concatMap (addr: [
      "${pkgs.iproute2}/bin/ip address add ${addr} dev ${name}"
    ])
    ipAddresses;
    
    ExecStart = "${pkgs.iproute2}/bin/ip link set ${name} up";

    ExecStop = "${pkgs.iproute2}/bin/ip link delete ${name}";
    OnFailure = "${pkgs.iproute2}/bin/ip link delete ${name}";
  };
}