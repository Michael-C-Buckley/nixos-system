{inputs, ...}: {
  imports = [
    inputs.vscode-server.nixosModules.default
    # inputs.home-manager.nixosModules.home-manager
    ./modules
    ./pkgs
    ./programs
    ./system
  ];

  environment.enableAllTerminfo = true;
  time.timeZone = "America/New_York";

  # Module-based Home-manager
  # home-manager.users.michael = inputs.michael-home.nixosModules.home.${host};
}
