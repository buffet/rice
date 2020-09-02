{ config, lib, ... }:
let
  cfg = config.buffet.services.mailserver;
  sources = import ../../nix/sources.nix;
in
  with lib; {
    imports = [
      (import sources.nixos-mailserver)
    ];

    options = {
      buffet.services.mailserver = {
        enable = mkEnableOption "mailserver";
      };
    };

    config = mkIf cfg.enable {
      security.acme.acceptTerms = true;
      security.acme.certs."mx.buffet.sh".email = "niclas@countingsort.com";

      mailserver = {
        enable = true;
        fqdn = "mx.buffet.sh";
        domains = [ "buffet.sh" ];

        loginAccounts = {
          "me@buffet.sh" = {
            hashedPassword = "$2y$05$jux3kZMyIEoZ8Hlaav2wmeFlC0K7ZS/FY7UI3Wi.ourVfEKa.yiCm";
            catchAll = [ "buffet.sh" ];
          };
        };

        # use Let's Encrypt certs
        certificateScheme = 3;

        enableImap = true;
        enableImapSsl = true;
        enableManageSieve = true;

        virusScanning = false;
      };
    };
  }
