{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    config = {
        user.name = "feelyourwarmth";
        user.email = "pientpvp@gmail.com";
      };
  };
}
