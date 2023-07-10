{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.buffet = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-wayland;

      profiles."buffet" = {
        extensions = with config.nur.repos.rycee.firefox-addons; [
          config.nur.repos.rycee.firefox-addons."10ten-ja-reader"
          bitwarden
          istilldontcareaboutcookies
          refined-github
          sidebery
          ublock-origin
        ];

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
