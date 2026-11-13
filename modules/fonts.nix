{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    (nerd-fonts.iosevka.overrideAttrs {
      postInstall = ''
        find $out/share/fonts -type f ! -name '*NerdFontMono*' -delete
      '';
    })
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    jetbrains-mono
  ];
}
