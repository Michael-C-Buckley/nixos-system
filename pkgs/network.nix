{ config, pkgs, lib, ... }: let
  netTools = config.features.pkgs.netTools;
  pkgList = with pkgs; [
    dig
    ethtool
    nmap
    iperf
    tcpdump
    lldpd
    cdpr
    nftables
    inetutils
    ndisc6
    wireguard-tools
    frr
    vlan
  ];
in {
  users.users = {
    michael.packages = lib.optionals netTools pkgList;
    root.packages = lib.optionals netTools  pkgList;
  };
}
