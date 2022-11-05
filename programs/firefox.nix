{
  config,
  pkgs,
  ...
}: {
  home-manager.users.buffet = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-wayland;

      extensions = with config.nur.repos.rycee.firefox-addons; [
        bitwarden
        https-everywhere
        i-dont-care-about-cookies
        refined-github
        sidebery
        ublock-origin
      ];

      profiles."buffet" = {
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };

        userChrome = ''
          #TabsToolbar {
            visibility: collapse !important;
          }
        '';
      };
    };
  };
}
