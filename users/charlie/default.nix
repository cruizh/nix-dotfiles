{ pkgs, lib, ... }:

{
  home-manager.users.charlie  = {
    programs.ssh.enable = true;
    programs.fish.enable = true;

    home.sessionVariables = {
      EDITOR = "gedit";
      VISUAL = "gedit";
    };

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      bitwarden bitwarden-cli
      tdesktop
      spotify
      discord
    ];
  };

  users.users.charlie = {
    uid = 1001;
    hashedPassword = lib.fileContents ../../secrets/charlie;
    description = "Charlie";
    isNormalUser = true;
  };
}
