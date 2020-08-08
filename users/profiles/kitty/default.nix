{ config, lib, pkgs, ... }:

{
  programs.kitty = {
  enable = true;
  font.name = "Fira Code";
  font.package = pkgs.fira-code;
  settings = {
    font_size = 13;
    shell = "fish";
    tab_bar_style = "powerline";
  };
};
}
