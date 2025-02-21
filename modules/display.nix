{config, lib, pkgs, ...}: {
  options.features.graphics = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable graphical features on host.";
  };

  config = lib.mkIf config.features.graphics {
    hardware.graphics.enable = true;

    services = {
      xserver.enable = true;
      displayManager = {
        defaultSession = "hyprland";
        autoLogin = {
          enable = true;
          user = "michael";
        };
        sddm = {
          enable = true;
          theme = "chili";
        };
      };
    };

    environment.systemPackages =  with pkgs; [
      sddm-chili-theme
    ];
  };
}