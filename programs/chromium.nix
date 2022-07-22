_: {
  nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";

  home-manager.users.buffet = {
    programs.chromium = {
      enable = true;
      extensions = [
        {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden
        {id = "gcbommkclmclpchllfjekcdonpmejbdp";} # HTTPS Everywhere
        {id = "hlepfoohegkhhmjieoechaddaejaokhf";} # Refined GitHub
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
      ];
    };
  };
}
