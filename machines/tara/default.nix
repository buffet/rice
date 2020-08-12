{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
  ];

  networking = {
    hostName = "tara";
    firewall.allowPing = true;
  };

  boot.cleanTmpDir = true;
  security.sudo.wheelNeedsPassword = false;
  services.openssh.enable = true;

  buffet = {
    programs = {
      bash.enable = true;
      git.enable = true;
      kak.enable = true;
      tmux.enable = true;
    };

    services = {
      blog.enable = true;
      mailserver.enable = true;
      trup.enable = true;
      website.enable = true;
    };
  };
}
