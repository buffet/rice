{lib, ...}: let
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

  home-manager.users.buffet = {
    programs.foot = let
      theme = import ../theme.nix;
    in {
      settings.main.font = lib.mkForce "${theme.font.family}:size=${toString (theme.font.size - 1)}";
    };

    wayland.windowManager.sway = {
      config.gaps.inner = lib.mkForce 5;
    };
  };
}
