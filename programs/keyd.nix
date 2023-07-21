_: {
  services.keyd = {
    enable = true;
    settings = {
      main = {
        "capslock" = "esc";
        "esc" = "capslock";
        "rightalt" = "enter";
      };
    };
  };
}
