{ pkgs, ... }:

{
  home-manager.users.cj  = {
    imports = [ ../profiles/lorri
                ../profiles/kitty
                ../profiles/kitty/themes/dracula
              ];

    programs.git.enable = true;

    home.sessionVariables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
    };

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      bitwarden bitwarden-cli
      spotify
      discord
      skypeforlinux
      gnomeExtensions.gsconnect
    ];

  };


  users.users.cj = {
    uid = 1000;
    initialPassword = "nixos";
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
