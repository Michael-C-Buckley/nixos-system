{lib, ...} : {
  # Default Nixos will have standard priority, force to override
  # environment.etc."frr/frr.conf".source = lib.mkForce config.age.secrets.frr.path;

  environment.etc."frr/frr.conf".text = lib.mkForce ''
  ip forwarding
  router ospf
   ospf router-id 192.168.48.10
  int wlp7s0
   ip ospf area 0
  int lo
   ip ospf area 0
   ip ospf passive
  '';

  services.frr = {
    bgpd.enable = true;
    eigrpd.enable = true;
    ospfd.enable = true;
    bgpd.options = [ "--limit-fds 2048" ];
    zebra.options = [ "--limit-fds 2048" ];
    openFilesLimit = 2048;
  };
}
