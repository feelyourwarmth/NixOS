{ pkgs, lib, ... }:

{
  # Portals
  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];

    config = {
      hyprland = lib.mkForce {
        default = [ "gnome" "gtk" "hyprland" ];

        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gnome" "gtk" ];
      };
      
      niri = lib.mkForce {
        default = [ "gnome" "gtk" ];

        "org.freedesktop.impl.portal.FileChooser" = [ "gnome" "gtk" ];
      };
    };
  };

  # Native Hyprland 1.5.0 share picker
  systemd.user.services.xdg-desktop-portal-hyprland = {
    serviceConfig.ExecStartPre = [
      "${pkgs.writeShellScript "hyprland-native-picker" ''
        config="/home/feel/.config/hypr/xdph.conf"

        if [ -f "$config" ]; then
          ${pkgs.gnused}/bin/sed -i \
            '/^[[:space:]]*custom_picker_binary[[:space:]]*=/d' \
            "$config"
        fi
      ''}"
    ];
  };
}
