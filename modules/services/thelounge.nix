{ config, lib, ... }:
let
  cfg = config.buffet.services.thelounge;
  sources = import ../../nix/sources.nix;

  port = 9000;
in
  with lib; {
    options = {
      buffet.services.thelounge = {
        enable = mkEnableOption "thelounge web IRC bouncer";
      };
    };

    config = mkIf cfg.enable {
      security.acme.acceptTerms = true;
      security.acme.certs."irc.buffet.sh".email = "niclas@countingsort.com";

      services = {
        thelounge = {
          enable = true;
          inherit port;
          private = true;

          extraConfig = {
            host = "127.0.0.1";
            reverseProxy = true;
            theme = "morning";
          };
        };

        nginx = {
          enable = true;

          recommendedGzipSettings = true;
          recommendedOptimisation = true;
          recommendedProxySettings = true;
          recommendedTlsSettings = true;

          virtualHosts."irc.buffet.sh" = {
            enableACME = true;
            forceSSL = true;

            locations."/" = {
              proxyPass = "http://localhost:${toString port}";
            };
          };
        };
      };
    };
  }
