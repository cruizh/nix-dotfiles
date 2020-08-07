{

  imports = [ ../users/cj ../users/root ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ahci" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/" =
    { device = "/dev/sda2";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/sda1";
      fsType = "vfat";
    };

  virtualisation.virtualbox.guest.enable = true;

  networking.hostName = "VirtualBox";
  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;

}
