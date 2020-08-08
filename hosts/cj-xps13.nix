{ lib, config, self, pkgs, ... }:

{
  imports =
    [
      ../users/cj
      ../users/root
      ../profiles/graphical/gnome
    ];

  hardware.enableRedistributableFirmware = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/" = {
    device = "UUID=f418c911-eee4-4171-acae-70915b905bd2";
    fsType = "btrfs";
    options = [ "subvol=nixos_root" ];
  };

  fileSystems."/home" = {
    device = "UUID=f418c911-eee4-4171-acae-70915b905bd2";
    fsType = "btrfs";
    options = [ "subvol=nixos_home" ];
  };

  fileSystems."/boot" = {
    device = "UUID=8E90-AA87";
    fsType = "vfat";
  };

  nix.maxJobs = lib.mkDefault 4;

  # High-DPI console
  console.packages = with pkgs; [ terminus_font ];
  console.font = lib.mkDefault "ter-u28n";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "i915.disable_power_well=0"
    "i915.enable_psr=1"
    "i915.enable_rc6=1"
    "i915.enable_guc=1"
    "i915.enable_fbc=1"
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
#    driSupport32Bit = true;
    extraPackages = [ pkgs.vaapiIntel ];
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  networking.useDHCP = false;
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    wget vim firefox git
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  # Enable SSD Trim
  services.fstrim.enable = true;

  # Enable OpenSSH
  services.openssh.enable = true;
  services.openssh.authorizedKeysFiles = [ "/etc/nixos/ssh_authorized_keys" ];
  programs.mosh.enable = true;

  # Enable sound with Bluetooth aptX and LDAC support
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

  system.stateVersion = "20.03";
}
# vim: set ts=2 sw=2 et:
