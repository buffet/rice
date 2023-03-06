_: {
  home-manager.users.buffet = {
    programs.sioyek = {
      enable = true;

      #config = with import ../theme.nix; {
      #  background_color = makeRgbFloat primary.background;
      #};
    };
  };
}
