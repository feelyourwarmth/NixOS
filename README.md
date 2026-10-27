> [!IMPORTANT]
> This configuration is tailored to my personal setup and **WILL NOT** work correctly on your system.
> <br>
> If you'd like to use it, treat it as a starting point and adapt it to your own profile, hardware, preferences and needs.

## how to larp like a master, best nixos config ever [TEL AVIV APPROVED]

```bash
git clone https://github.com/feelyourwarmth/NixOS.git ~/NixOS
rm ~/NixOS/hardware-configuration.nix
sudo rm /etc/nixos/configuration.nix
sudo cp -a ~/NixOS/. /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#nixos
reboot
```
