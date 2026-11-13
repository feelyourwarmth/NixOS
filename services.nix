{ config, pkgs, ... }:

{
  services.flatpak.enable = true;
  services.lact.enable = true;
  services.gvfs.enable = true;

  # Disable Speechd
  services.speechd.enable = false;

  systemd.services.fix-ryoku-permissions = {
    description = "Ensure Ryoku config directory has correct permissions";

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      mkdir -p /etc/nixos/config/ryoku
      chown feel:users /etc/nixos/config/ryoku
      chmod 0755 /etc/nixos/config/ryoku
    '';
  };

  systemd.services.fix-easyeffects-permissions = {
    description = "Ensure easyeffects config directory has correct permissions";

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      chown -R feel:users /etc/nixos/config/easyeffects
      chmod -R u+rwX /etc/nixos/config/easyeffects
    '';
  };

  
  systemd.services.fix-git-permissions = {
    description = "Ensure NixOS Git directory has correct permissions";

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      chown -R feel:users /etc/nixos/.git
      chmod -R u+rwX /etc/nixos/.git
    '';
  };

  systemd.services.fix-nvim-permissions = {
    description = "Ensure NixOS Nvim directory has correct permissions";

    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };

    script = ''
      set -eu

      # Ensure Neovim directories exist
      install -d -o feel -g users -m 0755 \
        /home/feel/.local/state \
        /home/feel/.local/share/nvim \
        /home/feel/.cache/nvim

      # Fix ownership and permissions
      for dir in \
        /home/feel/.local/state \
        /home/feel/.local/share/nvim \
        /home/feel/.cache/nvim \
        /etc/nixos/config/nvim
      do
        if [ -d "$dir" ]; then
          chown -R feel:users "$dir"
          chmod -R u+rwX "$dir"
        fi
      done
    '';
  };

systemd.user.services.sync-ryoku = {
    description = "Sync Ryoku config to NixOS";

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      set -euo pipefail

      LOCAL="$HOME/.config/ryoku"
      BACKUP="/etc/nixos/config/ryoku"

      # If the local Ryoku config does not exist or is empty,
      # restore it from the NixOS repository.
      if [ ! -d "$LOCAL" ] || [ -z "$(find "$LOCAL" -mindepth 1 -print -quit)" ]; then
        echo "Local Ryoku config is missing or empty."
        echo "Restoring from NixOS..."

        mkdir -p "$LOCAL"

        ${pkgs.rsync}/bin/rsync -a \
          "$BACKUP/" \
          "$LOCAL/"

        exit 0
      fi

      # Local configuration exists, so it is the source of truth.
      # Never delete anything from the NixOS repository.
      echo "Syncing local Ryoku config to NixOS..."

      ${pkgs.rsync}/bin/rsync -a \
        "$LOCAL/" \
        "$BACKUP/"

      echo "Ryoku synchronization complete."
    '';
  };

  systemd.user.timers.sync-ryoku = {
    description = "Periodically sync Ryoku config";

    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "30min";
    };

    wantedBy = [ "timers.target" ];
  };
}
