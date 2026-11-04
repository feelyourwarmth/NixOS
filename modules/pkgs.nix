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
    ncdu
    btop
    nh

    # TUI
    yazi

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
    pavucontrol

    # PACKAGES
    nil
    nixd
    tumbler
    starship
    zoxide
    eza
    bat
    fzf
    ffmpegthumbnailer
    ffmpeg-headless
    lm_sensors
    wlsunset
    lua5_1
    lua51Packages.luarocks
    vimPlugins.LazyVim
    lsp-plugins
    kdePackages.syntax-highlighting
    mangohud
    uv
    unzip
    unrar

    # LARP
    fetch
    fastfetch
    unimatrix
    cbonsai
    lavat
  ];

  qt.enable = true;

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
      libusb1
      libdrm
      libglvnd
      harfbuzz
      freetype
      fribidi
      libgpg-error
      gmp
      alsa-lib
      libxfixes
      libxscrnsaver
      libxtst
      wayland
      libxkbcommon
      libdecor
      dbus
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
