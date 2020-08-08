{ config, lib, pkgs, ... }:

{
  programs.kitty.extraConfig = ''
    include dracula.conf
  '';

  xdg.configFile = {
    "kitty/dracula.conf".source = ./dracula.conf;
    "kitty/diff.conf".source = ./diff.conf;
  };
}
