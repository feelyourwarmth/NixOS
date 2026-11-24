{
  inputs = {
    # Ryoku on NixOS local repo
    #ryoku = {
    #  url = "path:/home/feel/Ryoku-on-NixOS";
    #};
    
    ryoku = {
      url = "github:Ryoku-dev/Ryoku-on-NixOS/feature/hyperion-v2-nixos";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    valen = {
      url = "github:dodo986/valen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixcord = {
      url = "github:4evy/nixcord";
    };

    sls-steam = {
      url = "github:AceSLS/SLSsteam";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-float-sticky.url = "github:probeldev/niri-float-sticky";
  };

  outputs = { ryoku, valen, zen-browser, nixcord, sls-steam, niri-float-sticky, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
      #{ programs.ryoku.hyperionNiriOnly.enable = true; } # ryoku-v2-host-slim

      { programs.ryoku.hyperionPackages.enable = true; } # ryoku-v2-host-override

        ryoku.nixosModules.default
        ./modules/ryoku.nix
        ./configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.backupFileExtension = "backup";

          home-manager.extraSpecialArgs = {
            inherit inputs;
          };

          home-manager.users.feel = import ./home.nix;
        }
      ];
    };
  };
}

