{ config, lib, pkgs, ... }:

{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  services.gnome3.games.enable = false;
  environment.gnome3.excludePackages = with pkgs.gnome3; [
    # We use alternative software
    epiphany
    gnome-music
    totem

    # Makes little sense in NixOS
    gnome-software

    # I simply don't use these
    cheese
    gnome-photos
    gnome-weather
  ];
  programs.geary.enable = false;
}
