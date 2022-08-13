{pkgs, ...}: {
  home-manager.users.buffet = {
    programs.mako = let
      theme = import ../theme.nix;
    in {
      enable = true;

      anchor = "top-right";

      backgroundColor = theme.primary.background;
      borderColor = theme.wm.focused.border;
      progressColor = theme.primary.foreground;
      textColor = theme.primary.foreground;
      borderSize = 1;

      defaultTimeout = 4000;

      font = with theme; "${font.family} ${toString font.size}";
    };
  };
}
