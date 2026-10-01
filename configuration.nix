# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/fonts.nix
      ./modules/git.nix
      ./modules/nvidia.nix
      ./modules/rules.nix
      ./modules/pkgs.nix
      ./modules/nct6687.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."feel" = {
    isNormalUser = true;
    description = "feel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true; 

  programs.fish.shellFunctions = {
    rebuild = {
      body = ''
        sudo nixos-rebuild switch --flake /etc/nixos#nixos
        echo "Rebuild Complete!"
      '';
    };

    update = {
      body = ''
        sudo nix-channel --update
        sudo nix flake update --flake /etc/nixos
        sudo nixos-rebuild switch --flake /etc/nixos#nixos
        echo "Update Complete!"
      '';
    };

    clean = {
      body = ''
        sudo nix-collect-garbage -d
        echo "Nix garbage collection complete!"
      '';
    };

    nixos = {
      body = ''
        cd /etc/nixos
      '';
    };

    config = {
      body = ''
        sudo -E nvim /etc/nixos/configuration.nix
      '';
    };

    flake = {
      body = ''
        sudo -E nvim /etc/nixos/flake.nix
      '';
    };

    home = {
      body = ''
        sudo -E nvim /etc/nixos/home.nix
      '';
    };
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";

    XDG_CONFIG_HOME = "/home/feel/.config";
    XDG_DATA_HOME = "/home/feel/.local/share";
    XDG_STATE_HOME = "/home/feel/.local/state";
    XDG_CACHE_HOME = "/home/feel/.cache";
  };

  security.sudo.extraConfig = ''
    Defaults env_keep += "XDG_CONFIG_HOME"
    Defaults env_keep += "XDG_DATA_HOME"
    Defaults env_keep += "XDG_STATE_HOME"
    Defaults env_keep += "XDG_CACHE_HOME"
  '';

  system.stateVersion = "26.05";
}
