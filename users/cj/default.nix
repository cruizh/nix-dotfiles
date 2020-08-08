{ pkgs, ... }:

{
  home-manager.users.cj  = {
    imports = [ ../profiles/lorri
                ../profiles/kitty
                ../profiles/kitty/themes/dracula
                ../profiles/starship
              ];

    programs.git.enable = true;

    home.sessionVariables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
    };

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      bitwarden bitwarden-cli
      tdesktop
      spotify
      discord
      skypeforlinux
      gnomeExtensions.gsconnect
    ];

  };


  users.users.cj = {
    uid = 1000;
    hashedPassword = "$6$ww9uUxCwTf7tkV$7wKhIAVSR2it93yaa3KBqwxR0dGlXlAbHpDvitTOOwHTDIjW01WpV0AOz4bgwUwj54bV4SO/afEg54hNrhQ2w1";
    description = "Carlos José Ruiz-Henestrosa Ruiz";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
