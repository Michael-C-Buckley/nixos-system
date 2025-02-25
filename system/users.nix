{pkgs, inputs, ...}: let
  sshKeys = inputs.nix-secrets.nixosModules.sshKeys;
  allGroups = [ "networkmanager" "wheel" "video" "wireshark" ];
in {
  users = {
    users = {
      root = {
        openssh.authorizedKeys.keys = sshKeys.michael.personal;
      };
      michael = {
        isNormalUser = true;
        extraGroups = allGroups;
        initialHashedPassword = "$y$j9T$B7X2OiGnlXlAHCX77SKVL/$uhHb/UP4pHqEeZIzubxruA.U2ZYG3AK1x0xn/QcbLhC";
        openssh.authorizedKeys.keys = sshKeys.michael.personal;
      };
      shawn = {
        shell = pkgs.zsh;
        isNormalUser = true;
        extraGroups = allGroups;
        initialHashedPassword = "$y$j9T$B7X2OiGnlXlAHCX77SKVL/$uhHb/UP4pHqEeZIzubxruA.U2ZYG3AK1x0xn/QcbLhC";
        openssh.authorizedKeys.keys = sshKeys.shawn.personal;
      };
    };
  };
}
