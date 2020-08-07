{ lib, config, self, ... }:

{
  imports = [
    ../users/cj
    ../users/root
    ../profiles/graphical/gnome
  ];

  nix.maxJobs = lib.mkDefault 6;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-intel"
  ];


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d393c671-dc26-4cb9-92d3-6f9010da9f74";
      fsType = "btrfs";
      options = [ "subvol=@nixos" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E1E2-7F8E";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/d393c671-dc26-4cb9-92d3-6f9010da9f74";
      fsType = "btrfs";
      options = [ "subvol=@nixos_home" ];
    };

  networking.useDHCP = false;
  networking.networkmanager.enable = true;
}
