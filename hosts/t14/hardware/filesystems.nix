{...}: let
  zfsFs = name: {
    device = "rpool/root/${name}";
    fsType = "zfs";
  };
  bindMnt = device : {
    device = device;
    fsType = "none";
    options = ["bind"];
  };
in {
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/B227-3C56";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    "/" = zfsFs "nixos-2411";
    "/home"= zfsFs "home";
    "/nix" = zfsFs "nix";

    "/drives/xfs-pool" = {
      device = "/dev/disk/by-uuid/0e9f0e00-eca4-4d8f-a12f-7534b8939d9d";
      fsType = "xfs";
    };
    "/drives/ext4-pool" = {
      device = "/dev/disk/by-uuid/cdfdca97-9c34-41d6-9a7f-fa190c920088";
      fsType = "ext4";
    };

    # Bind mounts
    "/var/lib/libvirt" = bindMnt "/drives/xfs-pool/libvirt";
    "/var/lib/docker" = bindMnt "/drives/xfs-pool/docker";
    "/home/michael/Downloads" = bindMnt "/drives/ext4-pool/downloads";
    "/home/michael/Downloads/ISOs" = bindMnt "/drives/xfs-pool/downloads";
  };
}