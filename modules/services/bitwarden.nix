{ config, lib, ... }:
let
  cfg = config.buffet.services.bitwarden;
  port = 12224;
in
  with lib; {
    options = {
      buffet.services.bitwarden = {
        enable = mkEnableOption "bitwarden";
      };
    };

    config = mkIf cfg.enable {
      security.acme.acceptTerms = true;
      security.acme.certs."bitwarden.buffet.sh".email = "niclas@countingsort.com";

      services = {
        bitwarden_rs = {
          enable = true;

          config = {
            domain = "https://bitwarden.buffet.sh/";
            signupsAllowed = false;
            rocketPort = port;
          };
        };

        nginx = {
          enable = true;

          recommendedGzipSettings = true;
          recommendedOptimisation = true;
          recommendedProxySettings = true;
          recommendedTlsSettings = true;

          virtualHosts."bitwarden.buffet.sh" = {
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
