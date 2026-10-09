{
  nixConfig = {
    extra-substituters = [
      "https://attic.xuyh0120.win/lantian"
    ];
    extra-trusted-public-keys = [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };

  inputs = {
    ryoku = {
      url = "github:aethctl/Ryoku-on-NixOS/unstable-dev";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    sls-steam = {
      url = "github:AceSLS/SLSsteam";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ryoku, nix-cachyos-kernel, zen-browser, sls-steam, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ryoku.nixosModules.default
        ./modules/ryoku.nix
        ./configuration.nix

        ({ pkgs, ... }: {
          nixpkgs.overlays = [
            nix-cachyos-kernel.overlays.pinned
          ];
          boot.kernelPackages =
            pkgs.cachyosKernels.linuxPackages-cachyos-latest;
        })

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

