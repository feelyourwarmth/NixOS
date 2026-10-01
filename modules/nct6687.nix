{ config, ... }:

{
  boot.extraModulePackages = [
    config.boot.kernelPackages.nct6687d
  ];

  boot.kernelModules = [
    "nct6687"
  ];
}
