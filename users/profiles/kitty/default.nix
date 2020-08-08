{ config, lib, pkgs, ... }:

{
  programs.kitty = {
  enable = true;
  font.name = "Fira Code Regular Nerd Font Complete 13";
  font.package = pkgs.nerdfonts;
  settings = {
    shell = "fish";
    tab_bar_style = "powerline";
  };
};
}
