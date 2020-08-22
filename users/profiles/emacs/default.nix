{ config, lib, pkgs, ... }:

{
  programs.emacs.enable = true;

  home.packages = with pkgs; let
    fonts = [
      fira-code
      fira-code-symbols
      emacs-all-the-icons-fonts
    ];

    required = [
      ripgrep
      gnutls
    ];

    optional = [
      fd
      imagemagick
      pinentry_emacs
      zstd
    ];

    modules = [
      aspell
      aspellDicts.es
      aspellDicts.en aspellDicts.en-computers aspellDicts.en-science
      languagetool
      editorconfig-core-c
      (texlive.combine { inherit (texlive)
        scheme-medium
        collection-latexextra
        collection-fontsextra
      ;})
    ];
  in lib.concatLists [ fonts required optional modules ];
}
