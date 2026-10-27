{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # DEV
    neovim
    zed-editor
    python314Packages.pip

    # CLI
    curl
    nmap
    wget
    fetch
    ncdu
    btop

    # TUI
    claude-code

    # GIT
    lazygit
    github-cli

    # APPS
    openrgb
    brave-origin
    chromium
    lact
    gpu-screen-recorder-ui
    easyeffects
    (discord-canary.override { withVencord = true; }) # DISCORD CANARY + VENCORD
    equibop # EQUICORD
    proton-vpn
    mission-center
    nwg-look
    anydesk
    telegram-desktop

    # PACKAGES
    nil
    nixd
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

  # APPIMAGE SUPPORT FOR NIXOS
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld.enable = true;
}
