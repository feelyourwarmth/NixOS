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

  home.file.".config/kitty/user.conf".source =
    ./config/kitty/user.conf;

  home.file.".config/fastfetch/config.jsonc".source =
    ./config/fastfetch/config.jsonc;
  home.file.".config/fastfetch/user.txt".source =
    ./config/fastfetch/user.txt;

  home.file.".config/starship.toml".source =
    ./config/starship.toml;

  home.file.".config/niri/user.kdl".source =
    ./config/niri/user.kdl;

  home.file.".config/hypr/user.lua".source =
    ./config/hypr/user.lua;

  home.stateVersion = "26.05";
}

