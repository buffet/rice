_: {
  home-manager.users.buffet = {
    programs.alacritty = {
      enable = true;

      settings = {
        window.padding = {
          x = 8;
          y = 8;
        };

        font = with import ../theme.nix; {
          inherit (font) size;
          normal = {
            inherit (font) family;
            style = "Regular";
          };
          bold = {
            inherit (font) family;
            style = "Bold";
          };
          italic = {
            inherit (font) family;
            style = "Italic";
          };
          bold_italic = {
            inherit (font) family;
            style = "Bold Italic";
          };
        };

        colors = with import ../theme.nix; {
          primary = {
            inherit (primary) background foreground;
          };

          cursor = {
            cursor = cursor.background;
            text = cursor.foreground;
          };

          normal = {
            inherit (normal) black red green yellow blue magenta cyan white;
          };

          bright = {
            inherit (bright) black red green yellow blue magenta cyan white;
          };
        };
      };
    };
  };
}
