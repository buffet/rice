{ config, pkgs, ... }:
{
  services = {
    borgbackup = let
      repo = import ../../secrets/borg.nix;
    in
      {
        jobs.backup = {
          paths = [ "/etc" "/home" "/root" "/var" ];
          repo = "${repo.host}:tara";
          encryption.mode = "repokey";
          encryption.passphrase = repo.passphrase;
          startAt = "daily";
          environment.BORG_RSH = "ssh -i /home/buffet/.ssh/id_borg";
          extraArgs = "--remote-path borg1";
          prune.keep = {
            within = "1d";
            daily = 7;
            weekly = 4;
            monthly = -1;
          };
        };
      };
  };

  systemd.services = {
    borgbackup-job-backup = {
      after = [ "postgresql-dump.service" ];
      wants = [ "postgresql-dump.service" ];
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
  };
}
