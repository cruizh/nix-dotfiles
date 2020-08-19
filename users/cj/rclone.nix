{ pkgs, config, ... }:

{
  home.packages = [ pkgs.rclone ];
  home.file.".config/rclone/rclone.conf".source = ../../secrets/rclone.conf;
}
