_: {
  services.keyd = {
    enable = true;
    settings = {
      main = {
        "capslock" = "overload(control, esc)";
        "esc" = "capslock";
        "rightalt" = "layer(symbols)";
      };

      symbols = {
        "h" = "left";
        "j" = "down";
        "k" = "up";
        "l" = "right";
      };
    };
  };
}
