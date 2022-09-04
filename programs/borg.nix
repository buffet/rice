{config, ...}: let
  host = "11967@prio.ch-s011.rsync.net";
in {
  age.secrets.borgpassword.file = ../secrets/borgpassword.age;

  services.borgbackup = {
    jobs.backup = {
      paths = ["/persist"];
      repo = "${host}:${config.networking.hostName}";
      encryption = {
        mode = "repokey";
        passCommand = "cat ${config.age.secrets.borgpassword.path}";
      };
      startAt = "daily";
      persistentTimer = true;
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
}
