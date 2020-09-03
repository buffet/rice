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

  systemd.services = {
    borgbackup-job-backups.after = [ "postgresql-dump.service" ];

    postgresql-dump = {
      description = "postgresql backup";
      after = [ "postgresql.service" ];
      requires = [ "postgresql.service" ];

      script = let
        location = "/var/backup/postgrespql";
        postgres = config.services.postgresql;
      in
        ''
          umask 0077 # backup only readable by postgres user

          if [ -e ${location}/dump.sql.gz ]; then
              mv ${location}/dump.sql.gz ${location}/dump.old.sql.gz
          fi

          ${postgres.package}/bin/pg_dumpall | \
              ${pkgs.gzip}/bin/gzip -c >${location}/dump.sql.gz
        '';

      serviceConfig = {
        User = "postgres";
        Type = "oneshot";
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
        after = [ "borgbackup-job-backups.service" "network.target" ];
        requires = [ "network.target" ];

        serviceConfig = {
          ExecStart = "${pkgs.rclone}/bin/rclone sync --config ${configPath} \"${location}\" remote:${bucket}";
          User = "borg";
          Type = "oneshot";
        };
      };
  };
}
