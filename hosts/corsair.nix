{ lib, config, self, pkgs, pkgset, ... }:

{
  imports = [
    ../users/cj
    ../users/root
    ../profiles/graphical/gnome
  ];

  nix.maxJobs = lib.mkDefault 6;

  # Needed for AMDGPU Vega 10 binaries
  hardware.enableRedistributableFirmware = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];

  boot.kernelPackages = pkgset.pkgs.linuxPackages;
  boot.extraModulePackages = with pkgset.pkgs.linuxPackages; [ rtl88x2bu ];
  boot.kernelModules = [
    "kvm-intel"
    "rtl88x2bu"
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4d163d93-c8da-49cc-bfe4-b390e87f4770";
      fsType = "btrfs";
      options = [ "subvol=nixos/root" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E1E2-7F8E";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/4d163d93-c8da-49cc-bfe4-b390e87f4770";
      fsType = "btrfs";
      options = [ "subvol=nixos/home" ];
    };

  networking.useDHCP = false;
  networking.networkmanager.enable = true;
}
