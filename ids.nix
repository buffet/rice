{ lib, ... }:
with lib;
{
  options = {
    buffet.ids = {
      uids = mkOption {
        internal = true;
        type = types.attrsOf types.int;
        description = "The user IDs used by me.";
      };

      gids = mkOption {
        internal = true;
        type = types.attrsOf types.int;
        description = "The group IDs used by me.";
      };
    };
  };

  config = {
    buffet.ids = {
      uids = {
        buffet = 1000;
        trup = 1001;
        rclone = 1002;
      };

      gids = {
        trup = 1001;
        rclone = 1002;
      };
    };
  };
}
