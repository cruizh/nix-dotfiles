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
                ./rclone.nix
                ./cachix.nix
                ./mu.nix
              ];

    modules.mail.enable = true;

    programs.git = {
      enable = true;
      userName = fullName;
      userEmail = email;
      signing = {
        key = "5B21B0B57E85CB82";
        signByDefault = true;
      };
    };

    programs.ssh.enable = true;

    programs.fish = {
      enable = true;
      shellAliases = {
        windows = "systemctl reboot --boot-loader-entry=auto-windows";
      };
    };

    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };

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
      git-crypt
    ];

  };

  users.users.cj = {
    uid = 1000;
    hashedPassword = lib.fileContents ../../secrets/cj;
    description = fullName;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
