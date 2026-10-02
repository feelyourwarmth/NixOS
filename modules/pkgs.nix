{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # DEV
    neovim
    zed-editor

    # CLI
    curl
    wget
    nmap
    flatpak
    fetch
    ncdu
    btop

    # GIT
    lazygit
    github-cli

    # APPS
    shiru
    openrgb
    chromium
    lact
    gpu-screen-recorder-ui
    easyeffects
    (discord-canary.override { withVencord = true; }) # DISCORD CANARY
    #inputs.zen-browser.packages."${pkgs.system}".default # ZEN BROWSER
    proton-vpn
    mission-center

    # PACKAGES
    tumbler
    ffmpegthumbnailer
    ffmpeg-headless
    lm_sensors
    wlsunset
    lua5_1
    lua51Packages.luarocks
    vimPlugins.LazyVim
    lsp-plugins
    uv
    unzip
    mangohud

    # LARP
    unimatrix
    cbonsai
    lavat
  ];

  # STEAM WITH SLSSTEAM
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        LD_AUDIT = "${
          inputs.sls-steam.packages.${pkgs.stdenv.hostPlatform.system}.sls-steam
        }/library-inject.so:${
          inputs.sls-steam.packages.${pkgs.stdenv.hostPlatform.system}.sls-steam
        }/SLSsteam.so";
      };
    };
  };

  # COOLER CONTROL
  programs.coolercontrol = {
    enable = true;
  };
}
