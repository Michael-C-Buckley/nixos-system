{
  description = "Michael's System Flake";

  inputs = {
    # Following Cosmic to maximize Cachix hits and reduce duplication
    cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixpkgs.follows = "cosmic/nixpkgs";

    # Utilities
    ucodenix.url = "github:e-tho/ucodenix";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    wfetch.url = "github:iynaix/wfetch";
    
    nix-devshells = {
      url = "github:Michael-C-Buckley/nix-devshells";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.agenix.follows = "agenix";
    };

    nix-secrets = {
      url = "git+ssh://git@github.com/Michael-C-Buckley/nix-secrets";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.agenix.follows = "agenix";
      inputs.nix-devshells.follows = "nix-devshells";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nix-devshells,
    ...
  } @ inputs: let
    systemConfig = {host}: nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./default.nix
        ./hosts/${host}
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
