{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.desktop.firefox;
  sources = import ../../../nix/sources.nix;
  nur = import sources.nur { inherit pkgs; };
in
  with lib; {
    options = {
      buffet.desktop.firefox = {
        enable = mkEnableOption "firefox";
      };
    };

    config = mkIf cfg.enable {
      buffet.home = {
        home.sessionVariables = { BROWSER = "firefox"; };

        programs.firefox = {
          enable = true;
          package =
            if (config.buffet.desktop.sessionType == "wayland")
            then pkgs.firefox-wayland
            else pkgs.firefox;

          extensions = with nur.repos.rycee.firefox-addons; [
            bitwarden
            darkreader
            https-everywhere
            reddit-moderator-toolbox
            ublock-origin
            vimium
          ];

          profiles = {
            default = {
              isDefault = true;
              id = 0;

              userChrome = import ./userChrome.css.nix {
                colorscheme = config.buffet.desktop.colors;
              };

              settings = {
                "browser.ctrlTab.recentlyUsedOrder" = false;
                "browser.download.dir" = "/tmp/downloads";
                "browser.fullscreen.autohide" = false;
                "browser.shell.checkDefaultBrowser" = false;
                "browser.tabs.warnOnClose" = false;
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                "ui.key.menuAccessKey" = 0;
              };
            };
          };
        };
      };
    };
  }
