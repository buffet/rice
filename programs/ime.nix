{pkgs, ...}: {
  home-manager.users.buffet = {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-configtool
        fcitx5-gtk
        fcitx5-mozc
      ];
    };
  };
}
