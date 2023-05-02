{
  config,
  lib,
  impermanence,
  ...
}: {
  imports = [
    "${impermanence}/nixos.nix"
  ];

  environment.persistence."/persist/system" = {
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      "/root/.ssh"
      "/srv"
      "/var/lib/bluetooth"
      "/var/lib/docker"
      "/var/lib/machines"
      "/var/lib/portables"
      "/var/log"
    ];

    files = [];
  };

  programs.fuse.userAllowOther = true; # required for allowOther
  home-manager.users.buffet = {
    imports = [
      "${impermanence}/home-manager.nix"
    ];

    home.persistence."/persist/buffet" = {
      removePrefixDirectory = true;
      allowOther = true;

      directories = [
        "anki/.local/share/Anki"
        "anki/.local/share/Anki2"
        "crev/.local/share/crev"
        "data/books"
        "data/docs"
        "data/git"
        "data/proj"
        "data/reminders"
        "data/rice"
        "data/uni"
        "direnv/.local/share/direnv"
        "firefox/.cache/mozilla"
        "firefox/.mozilla"
        "gpg/.gnupg"
        "newsboat/.local/share/newsboat"
        "ssh/.ssh"
        "trash/.local/share/Trash"
      ];

      files = [
        "bash/.bash_history"
      ];
    };
  };

  fileSystems."/persist".neededForBoot = true;

  boot = {
    supportedFilesystems = ["btrfs"];

    # recreate the root subvolume at boot
    initrd.postDeviceCommands = lib.mkBefore ''
      echo "recreating root subvolume..."
      mkdir -p /mnt
      mount ${config.fileSystems."/".device} /mnt
      btrfs subvolume delete /mnt/@old
      mv /mnt/@ /mnt/@old
      btrfs subvolume create /mnt/@
      umount /mnt
      echo "done recreating subvolume"
    '';
  };

  # workaround for agenix running before /etc impermanence gets set up
  age.identityPaths = ["/persist/buffet/ssh/.ssh/id_agenix"];
}
