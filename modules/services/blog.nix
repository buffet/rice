{ config, lib, ... }:
let
  cfg = config.buffet.services.blog;
  sources = import ../../nix/sources.nix;
in
with lib; {
  options = {
    buffet.services.blog = {
      enable = mkEnableOption "blog";
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    security.acme.acceptTerms = true;
    security.acme.certs."blog.buffet.sh".email = "niclas@countingsort.com";

    services.nginx = {
      enable = true;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."blog.buffet.sh" = {
        enableACME = true;
        forceSSL = true;
        root = import sources.blog { };
      };
    };
  };
}

