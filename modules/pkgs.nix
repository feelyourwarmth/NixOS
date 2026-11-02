{ inputs, pkgs, ... }:

{
  imports = [ inputs.nixcord.nixosModules.nixcord ];
  environment.systemPackages = with pkgs; [
    # DEV
    neovim
    zed-editor
    python314Packages.pip

    # CLI
    curl
    nmap
    wget
    ncdu
    btop
    nh

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
    #proton-vpn
    nwg-look
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
    unrar

    # LARP
    fetch
    unimatrix
    cbonsai
    lavat
  ];

  # MODDED DISCORD
  programs.nixcord = {
    enable = true;
    user = "feel";
    discord.equicord.enable = true;
    discord.krisp.enable = true;
  };

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
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      gnutls
      icu
      fontconfig
      fuse
      e2fsprogs
      libx11
      libice
      libsm
      libxext
      libxrandr
      libxcursor
      libxi
      libxrender
      libxcb
      libjack2
      libpulseaudio
      vulkan-loader
    ];
  };

  # APPIMAGE SUPPORT FOR NIXOS
  programs.appimage = {
    enable = true;
    binfmt = false;
  };
}
