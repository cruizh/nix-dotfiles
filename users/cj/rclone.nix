{ pkgs, config, ... }:

let
  mountdir = "${config.home.homeDirectory}/Sync/OneDrive";
in
{
  home.packages = [ pkgs.rclone ];
  home.file.".config/rclone/rclone.conf".source = ../../secrets/rclone.conf;

  systemd.user.services = {
    rclone-onedrive = {
      Unit.Description = "Mount OneDrive";
      Unit.After = [ "network-online.target" ];
      Install.WantedBy = [ "multi-user.target" ];
      Service = {
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${mountdir}";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount us-onedrive: ${mountdir} \
          --vfs-cache-max-age 48h \
          --vfs-cache-mode full \
          --dir-cache-time 48h
        '';
        ExecStop = "/run/wrappers/bin/fusermount -u ${mountdir}";
        ExecStopPost = "/run/current-system/sw/bin/rmdir ${mountdir}";
        Type = "notify";
        Restart = "on-failure";
        RestartSec = "10s";
        Environment = [ "PATH=/run/wrappers/bin" ];
      };
    };
  };
}
