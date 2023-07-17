_: let
  password = "$6$FHwMlUwmRdAsPqS4$4XND0L0EEVf2Mhc/tvo6y3ZLIrMTOlsIZrG3w69EeXvtVZhdeNyoDOkPNIe.GBB8.PrchuUKDacqbvcvyuPkt0";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  # Don't change!
  system.stateVersion = "22.05";
  home-manager.users.buffet.home.stateVersion = "22.05";

  users.users.buffet.hashedPassword = password;
  users.users.root.hashedPassword = password;

  networking.hostName = "fanya";

  services.tlp.enable = true;
}
