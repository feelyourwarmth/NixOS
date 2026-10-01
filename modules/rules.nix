{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.configurationLimit = 5;

  nix.optimise = {
    automatic = true;
    dates = [ "daily" ];
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 5d";
  };

  nix.settings.auto-optimise-store = true;

  systemd.services.nixos-delete-old-generations = {
    description = "Keep only the 5 newest NixOS generations";

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      generations=$(nix-env -p /nix/var/nix/profiles/system --list-generations | awk '{print $1}' | sort -n)
      count=$(echo "$generations" | wc -l)

      if [ "$count" -gt 5 ]; then
        echo "$generations" | head -n -5 | while read generation; do
          nix-env -p /nix/var/nix/profiles/system --delete-generations "$generation"
        done
      fi
    '';
  };

  systemd.timers.nixos-delete-old-generations = {
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  services.udev.extraRules = ''
    # ATK / Compx - MAD68
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="105c", MODE="0660", GROUP="users", TAG+="uaccess"

    # ATK / Compx - MAD 8K DONGLE
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="1040", MODE="0660", GROUP="users", TAG+="uaccess"

    # ATK / Compx - MAD R MAJOR
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="103e", MODE="0660", GROUP="users", TAG+="uaccess"

    # USB device itself
    SUBSYSTEM=="usb", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="105c", MODE="0660", GROUP="users", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="1040", MODE="0660", GROUP="users", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="103e", MODE="0660", GROUP="users", TAG+="uaccess"
  '';

  security.wrappers.gsr-global-hotkeys = {
    source = "${pkgs.gpu-screen-recorder-ui}/bin/gsr-global-hotkeys";
    owner = "root";
    group = "root";
    capabilities = "cap_setuid+ep";
  };
}
