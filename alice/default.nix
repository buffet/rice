{nixos-hardware, ...}: let
  password = "$y$j9T$g/a4KaQ5VitWI9ZtAh9i3/$wjejk5W8LMc0gaVgw69kwrKLqBgZ95ekaOl/GaTOZVC";
in {
  imports = [
    nixos-hardware.nixosModules.lenovo-thinkpad-x270
    ./hardware-configuration.nix
  ];

  # Don't change!
  system.stateVersion = "23.05";
  home-manager.users.buffet.home.stateVersion = "23.05";

  users.users.buffet.hashedPassword = password;
  users.users.root.hashedPassword = password;

  networking.hostName = "alice";

  services.tlp = {
    enable = true;

    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1 = 80;
    };
  };
}
