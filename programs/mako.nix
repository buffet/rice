{pkgs, ...}: {
  home-manager.users.buffet = {
    home.packages = [pkgs.libnotify]; # TODO: is this required?

    programs.mako = let
      colors = import ../theme.nix;
    in {
      enable = true;

      anchor = "top-right";

      backgroundColor = colors.primary.background;
      borderColor = colors.wm.focused.border;
      progressColor = colors.primary.foreground;
      textColor = colors.primary.foreground;
      borderSize = 1;

      defaultTimeout = 4000;

      font = with import ../theme.nix; "${font.family} ${toString font.size}";
    };
  };
}
