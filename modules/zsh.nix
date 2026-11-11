{ pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestions = {
      enable = true;
      strategy = [ "history" "completion" ];
    };

    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --long --header --icons --group-directories-first";
      ll = "eza --long --all --header --icons --group-directories-first";
      la = "eza --all --header --icons --group-directories-first";
    };

    interactiveShellInit = lib.mkMerge [
      ''
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

        ryoku-fastfetch() {
          clear
          command ryoku-fastfetch "$@"
          printf '\e7'
          printf '\e[11;30Hi larp nixos'
          kitten icat --place 4x2@42x10 --transfer-mode=memory --stdin=no "$HOME/.config/fastfetch/emoji.gif"
          printf '\e8'
        }

        if (( $+commands[ryoku-fastfetch] )); then
          ryoku-fastfetch
        fi

        rebuild() {
          sudo -v
          sudo nixos-rebuild switch --flake /etc/nixos#nixos && echo "Rebuild Complete!"
        }

        update-flake() {
          sudo -v
          sudo nix-channel --update
          sudo nix flake update --flake /etc/nixos && echo "Flake Updated!"
        }

        update() {
          sudo -v
          ryoku status
          ryoku update
          sudo nix-channel --update
          sudo nix flake update --flake /etc/nixos
          sudo nixos-rebuild switch --flake /etc/nixos#nixos && echo "Update Complete!"
        }

        clean() {
          sudo -v
          sudo rm -rf /var/lib/systemd/coredump/*
          sudo rm -rf ~/.local/share/Steam/appcache/librarycache/*
          sudo nix-collect-garbage -d
          sudo nh clean all
          nix-store --optimise && echo "Nix garbage collection complete!"
        }

        nixos() {
          cd /etc/nixos
        }

        modules() {
          cd /etc/nixos/modules
        }

        nixfl() {
          sudo -E nvim /etc/nixos
        }

        config() {
          sudo -E nvim /etc/nixos/configuration.nix
        }

        flake() {
          sudo -E nvim /etc/nixos/flake.nix
        }

        home() {
          sudo -E nvim /etc/nixos/home.nix
        }

        pkgs() {
          sudo -E nvim /etc/nixos/modules/pkgs.nix
        }

        services() {
          sudo -E nvim /etc/nixos/services.nix
        }

        nixcord() {
          sudo -E nvim /etc/nixos/modules/nixcord.nix
        }

        larp() {
          fetch --infinite --shading-mode sextants
        }
      ''

      (lib.mkAfter ''
        _zsh_autosuggest_strategy_validated() {
          _zsh_autosuggest_strategy_history "$1"

          local cmd="$suggestion"
          if [[ "$cmd" == (cd|pushd)\ * ]]; then
            local dir="''${cmd#* }"
            dir="''${(Q)dir}"
            dir="''${dir/#\~/$HOME}"
            if [[ "$dir" != "-" && ! -d "$dir" ]]; then
              suggestion=""
            fi
          fi
        }

        ZSH_AUTOSUGGEST_STRATEGY=(validated completion)
      '')
    ];

    promptInit = ''
      eval "$(${pkgs.starship}/bin/starship init zsh)"
    '';

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.feel.shell = pkgs.zsh;

  environment.localBinInPath = true;
}
