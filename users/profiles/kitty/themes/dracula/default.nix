{ config, lib, pkgs, ... }:

{
  programs.kitty.extraConfig = ''
    include dracula.conf
    include diff.conf
  '';

  xdg.configFile = {
    "kitty/dracula.conf".source = ./dracula.conf;
    "kitty/diff.conf".source = ./diff.conf;
  };
}
