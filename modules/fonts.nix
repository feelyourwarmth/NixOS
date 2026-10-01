{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    jetbrains-mono
  ];
}
