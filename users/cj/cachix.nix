{ pkgs, lib, ... }:

{
  home.packages = [ pkgs.cachix ];
  home.file.".config/cachix/cachix.dhall".source = ../../secrets/cachix.dhall;
}
