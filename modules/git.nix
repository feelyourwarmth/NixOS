{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    config = {
        user.name = "feelyourwarmth";
        user.email = "pientpvp@gmail.com";
        pull.rebase = false;

        # GitHub CLI authentication
        credential."https://github.com".helper = [
          ""
          "!${pkgs.gh}/bin/gh auth git-credential"
        ];
      };
  };

  programs.fish.shellFunctions = {
    gs = {
      body = ''
        git status
      '';
    };
  };
}
