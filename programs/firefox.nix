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

      extensions = with config.nur.repos.rycee.firefox-addons;
      let
        # TODO: switch to yomitan
        yomichan = buildFirefoxXpiAddon {
          pname = "yomichan";
          version = "20.5.22.1";
          addonId = "alex@foosoft.net";
          url = "https://addons.mozilla.org/firefox/downloads/file/3585060/yomichan-20.5.22.1.xpi";
          sha256 = "sha256-/icvPD/nCJYS31owfYMD25QzFjsxAqapy/UAehhxsy8=";
          meta = with lib; {
            description = "Yomichan turns your browser into a tool for building Japanese language literacy by helping you to decipher texts which would be otherwise too difficult tackle. It features a robust dictionary with EPWING and flashcard creation support.";
            license = licenses.gpl3;
            platforms = platforms.all;
          };
        };
      in [
        bitwarden
        i-dont-care-about-cookies
        refined-github
        sidebery
        ublock-origin
        yomichan
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
