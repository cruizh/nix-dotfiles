{ pkgs, lib, ... }:

let
  fullName = "Carlos José Ruiz-Henestrosa Ruiz";
  email = "ruizh.cj@gmail.com";
in
{
  home-manager.users.cj  = {
    imports = [ ../profiles/lorri
                ../profiles/kitty
                ../profiles/kitty/themes/dracula
                ../profiles/starship
                ../profiles/emacs
              ];

    programs.git = {
      enable = true;
      userName = fullName;
      userEmail = email;
    };

    programs.ssh.enable = true;
    programs.fish.enable = true;

    home.sessionVariables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
    };

    fonts.fontconfig.enable = lib.mkForce true;

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
    description = fullName;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
