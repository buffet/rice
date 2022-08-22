{pkgs, ...}: {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  home-manager.users.buffet = {
    programs.gpg.enable = true;
  };
}
