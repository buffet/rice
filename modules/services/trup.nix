{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.services.trup;
  postgres = config.services.postgresql;
  sources = import ../../nix/sources.nix;
in
with lib; {
  options = {
    buffet.services.trup = {
      enable = mkEnableOption "trup";
    };
  };

  config = mkIf cfg.enable {
    security.sudo.enable = true;
    services.postgresql.enable = true;

    users.groups.trup = {
      gid = config.buffet.ids.gids.trup;
    };

    users.users.trup = {
      description = "trup service user";
      group = "trup";
      shell = "/bin/sh";
      uid = config.buffet.ids.uids.trup;
    };

    systemd.services.trup = {
      description = "trup Discord bot";
      after = [ "postgresql.service" "network.target" ];
      requires = [ "postgresql.service" "network.target" ];
      wantedBy = [ "multi-user.target" ];

      environment = import ../../secrets/trup-secret.nix;

      preStart = ''
          ${pkgs.busybox}/bin/su -- ${postgres.superUser} \
              -c "${postgres.package}/bin/createuser -s trup || true"

          ${pkgs.busybox}/bin/su -- ${postgres.superUser} \
              -c "${postgres.package}/bin/createdb -O trup trup || true"

          ${pkgs.busybox}/bin/su -- trup \
              -c "${postgres.package}/bin/psql trup <${sources.trup}/db/structure.sql || true"
      '';

      serviceConfig = {
        ExecStart = "${pkgs.trup}/bin/trup";
        User = "trup";
        Type = "simple";
        Restart = "always";
        PermissionsStartOnly = true;
      };
    };
  };
}
