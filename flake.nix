{
  description = "Michael's System Flake";

  inputs = {
    # Following Cosmic to maximize Cachix hits and reduce duplication
    cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixpkgs.follows = "cosmic/nixpkgs";
    nixpkgs-stable.follows = "cosmic/nixpkgs-stable";

    hyprland.url = "github:hyprwm/hyprland";

    # User configs
    michael-home = {
      url = "github:Michael-C-Buckley/home-config";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "";
    };
    hjem.follows = "michael-home/hjem";

    # Utilities
    ucodenix.url = "github:e-tho/ucodenix";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    wfetch.url = "github:iynaix/wfetch";
    
    nix-devshells = {
      url = "github:Michael-C-Buckley/nix-devshells";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@github.com/Michael-C-Buckley/nix-secrets";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-devshells.follows = "nix-devshells";
    };

    nixos-modules = {
      url = "github:Michael-C-Buckley/nixos-modules";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-devshells.follows = "nix-devshells";
    };

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
