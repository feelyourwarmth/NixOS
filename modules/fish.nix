{ ... }:

{
  programs.fish.shellFunctions = {
    ryoku-fastfetch = {
      body = ''
        clear
        command ryoku-fastfetch $argv
        printf '\e7'
        printf '\e[11;30Hi larp nixos'
        kitten icat --place 4x2@42x10 --transfer-mode=memory --stdin=no ~/.config/fastfetch/emoji.gif
        printf '\e8'
      '';
    };

    rebuild = {
      body = ''
        sudo -v
        sudo nixos-rebuild switch --flake /etc/nixos#nixos
        echo "Rebuild Complete!"
      '';
    };

    update = {
      body = ''
        sudo -v
        ryoku status
        ryoku update
        sudo nix-channel --update
        sudo nix flake update --flake /etc/nixos
        sudo nixos-rebuild switch --flake /etc/nixos#nixos
        echo "Update Complete!"
      '';
    };

    clean = {
      body = ''
        sudo -v
        sudo nh clean all
        sudo nix-collect-garbage -d
        echo "Nix garbage collection complete!"
      '';
    };

    nixos = {
      body = ''
        cd /etc/nixos
      '';
    };

    nixfl = {
      body = ''
        sudo -E nvim /etc/nixos
      '';
    };

    modules = {
      body = ''
        cd /etc/nixos/modules
      '';
    };

    config = {
      body = ''
        sudo -E nvim /etc/nixos/configuration.nix
      '';
    };

    flake = {
      body = ''
        sudo -E nvim /etc/nixos/flake.nix
      '';
    };

    home = {
      body = ''
        sudo -E nvim /etc/nixos/home.nix
      '';
    };

    pkgs = {
      body = ''
        sudo -E nvim /etc/nixos/modules/pkgs.nix
      '';
    };

    services = {
      body = ''
        sudo -E nvim /etc/nixos/modules/services.nix
      '';
    };

    larp = {
      body = ''
        fetch --infinite --shading-mode sextants
      '';
    };
  };
}
