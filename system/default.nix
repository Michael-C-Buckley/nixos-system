{...}: {
  imports = [
    ./boot.nix
    ./hardware.nix
    ./nix.nix
    ./security.nix
    ./users.nix
  ];

  time.timeZone = "America/New_York";
}
