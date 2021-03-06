{ config, lib, pkgs, ... }:
let inherit (lib) fileContents;

in
{
  nix.package = pkgs.nixFlakes;

  nix.systemFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];

  imports = [ ../../local/locale.nix ];

  environment = {

    systemPackages = with pkgs; [
      binutils
      coreutils
      curl
      direnv
      dnsutils
      dosfstools
      fd
      git
      gotop
      gptfdisk
      iputils
      jq
      moreutils
      nmap
      ripgrep
      utillinux
      whois
    ];

    shellAliases =
      let ifSudo = lib.mkIf config.security.sudo.enable;
      in
      {
        # quick cd
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";

        # git
        g = "git";

        # grep
        grep = "rg";
        gi = "grep -i";

        # internet ip
        myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

        # nix
        n = "nix";
        np = "n profile";
        ni = "np install";
        nr = "np remove";
        ns = "n search --no-update-lock-file";
        nf = "n flake";
        srch = "ns nixpkgs";
        nrb = ifSudo "sudo nixos-rebuild";

        # sudo
        s = ifSudo "sudo -E ";
        si = ifSudo "sudo -i";
        se = ifSudo "sudoedit";

        # top
        top = "gotop";

        # systemd
        ctl = "systemctl";
        stl = ifSudo "s systemctl";
        utl = "systemctl --user";
        ut = "systemctl --user start";
        un = "systemctl --user stop";
        up = ifSudo "s systemctl start";
        dn = ifSudo "s systemctl stop";
        jtl = "journalctl";

      };

  };

  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      noto-fonts
      noto-fonts-emoji
      fira-code
      fira-code-symbols
    ];

    fontconfig.defaultFonts = {
      monospace = [ "DejaVu Sans Mono for Powerline" ];
      sansSerif = [ "DejaVu Sans" ];
    };
  };

  nix = {
    autoOptimiseStore = true;
    gc.automatic = true;
    optimise.automatic = true;
    useSandbox = true;
    allowedUsers = [ "@wheel" "@users" ];
    trustedUsers = [ "root" "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
      min-free = 536870912
    '';
  };


  security = {
    hideProcessInformation = lib.mkDefault true;
    protectKernelImage = true;
    wrappers.fusermount.source = "${pkgs.fuse}/bin/fusermount";
  };

  services.earlyoom.enable = true;
  users.mutableUsers = false;

  systemd.services.systemd-udev-settle.enable = false;
}
