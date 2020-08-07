{ config, lib, pkgs, ... }:

{
  programs.kitty = {
  enable = true;
  font.name = "Fira Code 13";
  font.package = pkgs.fira-code;
  settings = {
    shell = "fish";
    tab_bar_style = "powerline";
  };
};
}
