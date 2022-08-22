{
  config,
  lib,
  impermanence,
  ...
}: {
  imports = [
    "${impermanence}/nixos.nix"
  ];

  # TODO: chromium persistent
  # TODO: brightness persistent

  environment.persistence."/persist/system" = {
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      "/srv"
      "/var/lib/bluetooth"
      "/var/lib/machines"
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
        "data/books"
        "data/docs"
        "data/git"
        "data/proj"
        "data/reminders"
        "data/rice"
        "data/uni"
        "gpg/.gnupg"
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
      btrfs subvolume delete /mnt/@
      btrfs subvolume create /mnt/@
      umount /mnt
    '';
  };

  # workaround for agenix running before /etc impermanence gets set up
  age.identityPaths = ["/persist/buffet/ssh/.ssh/id_rsa"];
}
