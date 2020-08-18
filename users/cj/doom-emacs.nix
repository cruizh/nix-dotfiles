{ lib, pkgs, ... }:

let
  doom-emacs = pkgs.callPackage (pkgs.fetchFromGitHub {
    owner = "vlaci";
    repo = "nix-doom-emacs";
    rev = "edea767bd1a5cf2bbf00760f6070ecf1c2490ebc";
    sha256 = "16q5n8ha7hq8cmc85490dr37q6swr2b87wd6bihxbdcb0hbwik5j";
  }) {
    doomPrivateDir = ./doom;
  };
in
{
  home.packages = with pkgs; let
    base = [ doom-emacs ];

    fonts = [
      fira-code
      fira-code-symbols
      emacs-all-the-icons-fonts
    ];

    tex = [ (texlive.combine { inherit (texlive)
      scheme-medium
      collection-latexextra
      collection-fontsextra
    ;})];

    spell = [
      aspell
      languagetool
    ] ++ (with pkgs.aspellDicts; [
      es
      en en-computers en-science
    ]);

    in lib.concatLists [ base fonts tex spell ];

  home.file.".config/emacs/init.el".text = ''
    (load "default.el")
  '';
}
