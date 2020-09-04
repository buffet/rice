{ config, pkgs, ... }:
let
  location = "/var/borgbackup";
in
{
  services = {
    borgbackup = {
      repos.backups = {
        allowSubRepos = true;
        authorizedKeys = import ../../keys.nix;
        group = "rclone";
        path = location;
      };

      jobs.backup = {
        paths = [ "/etc" "/home" "/root" "/var" ];
        exclude = [ location ];
        repo = "${location}/tara";
        encryption.mode = "none"; # TODO: encrypt
        startAt = "daily";
      };
    };
  };

  systemd = {
    services = {
      borgbackup-job-backup = {
        after = [ "postgresql-dump.service" ];
        before = [ "rclone-sync-backups.service" ];
        wants = [ "postgresql-dump.service" "rclone-sync-backups.service" ];
      };

      postgresql-dump = let
        location = "/var/backup/postgresql";
        postgres = config.services.postgresql;
      in
        {
          description = "postgresql backup";
          after = [ "postgresql.service" ];
          requires = [ "postgresql.service" ];

          preStart = ''
            mkdir -p "${location}"
            chown postgres:postgres "${location}"
            chmod 770 "${location}"
          '';

          script = ''
            umask 0077 # backup only readable by postgres user

            if [ -e "${location}/dump.sql.gz" ]; then
                mv "${location}/dump.sql.gz" "${location}/dump.old.sql.gz"
            fi

            ${postgres.package}/bin/pg_dumpall | \
                ${pkgs.gzip}/bin/gzip -c >"${location}/dump.sql.gz"
          '';

          serviceConfig = {
            User = "postgres";
            Type = "oneshot";
            PermissionsStartOnly = true;
          };
        };

      rclone-sync-backups = let
        makeRemoteConfig = remote: with remote; ''
          [remote]
          type = ${type}
          env_auth = ${if env_auth then "true" else "false"}
          access_key_id = ${access_key_id}
          secret_access_key = ${secret_access_key}
          region = ${region}
          endpoint = ${endpoint}
          location_contraint = ${location_contraint}
        '';

        configPath = pkgs.writeText "rclone.conf" (makeRemoteConfig (import ../../secrets/wasabi.nix));
        bucket = "buffet-backups";
      in
        {
          description = "Sync backups to S3 remote";
          after = [ "network.target" ];
          requires = [ "network.target" ];

          serviceConfig = {
            ExecStart = "${pkgs.rclone}/bin/rclone sync --config ${configPath} \"${location}\" remote:${bucket}";
            Type = "oneshot";
          };
        };
    };

    timers.rclone-sync-backups = {
      wantedBy = [ "timers.target" ];
      partOf = [ "rclone-sync-backups.service" ];
      timerConfig.OnCalendar = "hourly";
    };
  };
}
