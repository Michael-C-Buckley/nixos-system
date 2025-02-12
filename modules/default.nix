{inputs, ...}: {
  imports = with inputs.nixos-modules.nixosModules; [
    zfs
    ./desktops
    ./virtualization
    ./display.nix
    ./gaming.nix
  ];
}
