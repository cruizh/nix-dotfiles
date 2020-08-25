{ config, options, lib, pkgs, ... }:

with lib;
let
  name = "Carlos José Ruiz-Henestrosa Ruiz";
  gmail = "ruizh.cj@gmail.com";
  us = "carruirui3@alum.us.es";
  maildir = "/home/cj/.mail";
in {
  options.modules.mail.enable = mkEnableOption "mail with mu";

  config = mkIf config.modules.mail.enable {
    home.packages = with pkgs; [ mu isync ];
    accounts.email = {
      maildirBasePath  = maildir;
      accounts = {
        Gmail = {
          address = gmail;
          flavor = "gmail.com";
          passwordCommand = "${pkgs.pass}/bin/pass Email/GmailApp | head -n1";
          primary = true;
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            patterns = [ "*" "[Gmail]*" ];
          };
          realName = name;
          msmtp.enable = true;
          folders = {
            inbox = "Inbox";
            drafts = "[Gmail]/Borradores";
            sent = "[Gmail]/Enviados";
            trash = "[Gmail]/Papelera";
          };
        };
        US = {
          address = us;
          userName = us;
          flavor = "plain";
          passwordCommand = "${pkgs.pass}/bin/pass Edu/US | head -n1";
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            patterns = [ "*" ];
          };
          imap = {
            host = "buzon.us.es";
            port = 993;
            tls.enable = true;
          };
          realName = name;
          msmtp.enable = true;
          smtp = {
            host = "mail.us.es";
            port = 587;
            tls.useStartTls = true;
          };
        };
      };
    };
    programs = {
      msmtp.enable = true;
      mbsync.enable = true;
    };
    services.mbsync = {
      enable = true;
      frequency = "*:0/15";
      preExec = "${pkgs.isync}/bin/mbsync -Ha";
      postExec = "${pkgs.mu}/bin/mu index -m ${maildir}";
    };
  };
}
