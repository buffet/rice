{pkgs, ...}: {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "curses";
  };

  home-manager.users.buffet = {
    programs.gpg.enable = true;
  };
}
