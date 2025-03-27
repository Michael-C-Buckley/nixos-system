{
  description = "Michael's System Flake";

  inputs = {
    # Following Cosmic to maximize Cachix hits and reduce duplication
    cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixpkgs.follows = "cosmic/nixpkgs";
    nixpkgs-stable.follows = "cosmic/nixpkgs-stable";
    lix.url = "git+https://git.lix.systems/lix-project/lix";

    # User configs
    michael-home = {
      url = "github:Michael-C-Buckley/home-config";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "";
    };
    hyprland.url = "github:hyprwm/hyprland";
    hjem.follows = "michael-home/hjem";
    wfetch.url = "github:iynaix/wfetch";

    # Custom Modules
    nix-devshells.url = "github:Michael-C-Buckley/nix-devshells";
    nix-secrets.url = "git+ssh://git@github.com/Michael-C-Buckley/nix-secrets";
    nixos-modules.url = "github:Michael-C-Buckley/nixos-modules";

    # Utilities
    ucodenix.url = "github:e-tho/ucodenix";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    ragenix.url = "github:yaxitech/ragenix";
    microvm.url = "github:astro/microvm.nix";
  };

  outputs = {
    nixpkgs,
    nix-devshells,
    michael-home,
    ...
  } @ inputs: let
    stablePkgs = import inputs.nixpkgs-stable {system="x86_64-linux"; config.allowUnfree = true;};
    systemConfig = {host}: nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs stablePkgs host;};
      modules = [
        ./default.nix
        ./hosts/${host}
        michael-home.nixosModules.hjem.${host}
      ];
    };
    hosts = [
      "x570"
      "t14"
      "p520"
    ];
  in {
    nixosConfigurations = builtins.listToAttrs (map (host: {
        name = host;
        value = systemConfig {inherit host;};
      })
      hosts);

    checks = nix-devshells.checks;
    devShells.x86_64-linux.default = nix-devshells.devShells.x86_64-linux.nixos;
  };
}
