{ pkgs, config, ... }:

let
  mountdir = "${config.home.homeDirectory}/Sync";
in
{
  home.packages = [ pkgs.rclone ];
  home.file.".config/rclone/rclone.conf".source = ../../secrets/rclone.conf;

  systemd.user.services = {
    "rclone@" = {
      Unit.Description = "Mount OneDrive";
      Unit.After = [ "network-online.target" ];
      Install.WantedBy = [ "multi-user.target" ];
      Service = {
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${mountdir}/%i";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount %i: "${mountdir}/%i" \
          --vfs-cache-max-age 48h \
          --vfs-cache-mode full \
          --dir-cache-time 48h
        '';
        ExecStop = "/run/wrappers/bin/fusermount -u \"${mountdir}/%i\"";
        ExecStopPost = "/run/current-system/sw/bin/rmdir \"${mountdir}/%i\"";
        Type = "notify";
        Restart = "on-failure";
        RestartSec = "10s";
        Environment = [ "PATH=/run/wrappers/bin" ];
      };
    };
  };
}
