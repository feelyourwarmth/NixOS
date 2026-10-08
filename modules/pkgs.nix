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
    fetch
    ncdu
    btop
    nvibrant

    # GIT
    lazygit
    github-cli

    # APPS
    openrgb
    brave-origin
    vivaldi
    chromium
    lact
    gpu-screen-recorder-ui
    easyeffects
    (discord-canary.override { withVencord = true; }) # DISCORD CANARY
    proton-vpn
    mission-center
    nwg-look
    gnome-disk-utility
    anydesk

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
