_: {
  services.keyd = {
    enable = true;
    settings = {
      capslock = "overload(control, esc)";
      esc = "capslock";
    };
  };
}
