{config, lib, pkgs, ...}: let 
  virtCfg = config.custom.virtualisation;
in {

  options.custom.virtualisation.gns3 = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GNS3 on the host.";
    };
  };

  config = lib.mkIf virtCfg.gns3.enable {
    environment.systemPackages = with pkgs; [
      dynamips
      alacritty # For the consoles for GNS nodes, for now, may change later
      gns3-gui
      gns3-server
    ];

    services = {
      gns3-server = {
        enable = true;
        ubridge.enable = true;
      };
    };
  };
}