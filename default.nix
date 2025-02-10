{inputs, ...}: {
  imports = [
    inputs.vscode-server.nixosModules.default
    ./modules
    ./pkgs
    ./programs
    ./system
  ];

  environment.enableAllTerminfo = true;
  time.timeZone = "America/New_York";
}
