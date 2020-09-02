{ config, lib, ... }:
let
  cfg = config.buffet.services.website;
  sources = import ../../nix/sources.nix;
in
  with lib; {
    options = {
      buffet.services.website = {
        enable = mkEnableOption "website";
      };
    };

    config = mkIf cfg.enable {
      networking.firewall.allowedTCPPorts = [ 80 443 ];

      security.acme.acceptTerms = true;
      security.acme.certs."buffet.sh".email = "niclas@countingsort.com";

      services.nginx = {
        enable = true;

        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;

        virtualHosts."buffet.sh" = {
          enableACME = true;
          forceSSL = true;
          root = sources.website;
        };
      };
    };
  }
