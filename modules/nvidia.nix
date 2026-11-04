{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
  environment.sessionVariables = {
    #__EGL_EXTERNAL_PLATFORM_CONFIG_DIRS =
    #  "/run/opengl-driver/share/egl/egl_external_platform.d/";
    GSK_RENDERER = "ngl";
    SDL_VULKAN_LIBRARY = "/run/current-system/sw/share/nix-ld/lib/libvulkan.so.1";
  };
}
