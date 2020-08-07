{
  users.users.cj = {
    uid = 1000;
    initialPassword = "nixos";
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
