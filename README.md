## how to larp like a master, best nixos config ever [TEL AVIV APPROVED]

```bash
git clone https://github.com/feelyourwarmth/NixOS.git ~/NixOS
sudo rm /etc/nixos/configuration.nix
sudo cp -a ~/NixOS/. /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#nixos
reboot
```
