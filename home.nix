{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
      sine.enable = true;
    };
  };

  # KITTY CONFIG
  home.file.".config/kitty/user.conf".source =
    ./config/kitty/user.conf;

  # FASTFETCH CONFIG
  home.file.".config/fastfetch/config.jsonc".source =
    ./config/fastfetch/config.jsonc;
  home.file.".config/fastfetch/user.txt".source =
    ./config/fastfetch/user.txt;

  # STARSHIP CONFIG
  home.file.".config/starship.toml".source =
    ./config/starship.toml;

  # NIRI CONFIG
  home.file.".config/niri/user.kdl".source =
    ./config/niri/user.kdl;

  # HYPR CONFIG
  home.file.".config/hypr/user.lua".source =
    ./config/hypr/user.lua;

  # EASYEFFECTS CONFIG
  home.file.".config/easyeffects".source =
    ./config/easyeffects;

  # LAZYVIM CONFIG
  home.file.".config/nvim".source =
    ./config/nvim;

  home.stateVersion = "26.05";
}

