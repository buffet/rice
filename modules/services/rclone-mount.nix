{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.services.rclone-mount;
  sources = import ../../nix/sources.nix;
  nixpkgs-unstable = import sources.nixpkgs-unstable { };
in
with lib;
{
  options = {
    buffet.services.rclone-mount = {
      enable = mkEnableOption "rclone mount";

      mounts = mkOption {
        default = { };

        type = types.attrsOf (types.submodule {
          options = {
            mountpoint = mkOption {
              type = types.path;
              example = "/mnt/remote";
              description = ''
                Location to mount the remote to.
              '';
            };

            path = mkOption {
              type = types.str;
              description = ''
                The remote path that should be mounted.
              '';
            };

            # XXX: only supports s3
            remote = {
              type = mkOption {
                type = types.str;
              };

              env_auth = mkOption {
                default = false;
                type = types.bool;
              };

              access_key_id = mkOption {
                type = types.str;
              };

              secret_access_key = mkOption {
                type = types.str;
              };

              region = mkOption {
                type = types.str;
              };

              endpoint = mkOption {
                type = types.str;
              };

              location_contraint = mkOption {
                type = types.str;
              };
            };
          };
        });
      };
    };
  };

  config = mkIf cfg.enable {
    users.groups.rclone = {
      gid = config.buffet.ids.gids.rclone;
    };

    users.users.rclone = {
      description = "rclone mount service user";
      group = "rclone";
      uid = config.buffet.ids.uids.rclone;
    };

    programs.fuse.userAllowOther = true;

    systemd.services = let
      makeService = name: mount: let
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

        configPath = pkgs.writeText "rclone.conf" (makeRemoteConfig mount.remote);
      in {
        name = "rclone-mount-${name}";
        value = with mount; {
          description = "rclone mount ";
          after = [ "network.target" ];
          requires = [ "network.target" ];
          wantedBy = [ "multi-user.target" ];

          preStart = ''
            mkdir -p "${mountpoint}"
            chown rclone:rclone "${mountpoint}"
            chmod 770 "${mountpoint}"
          '';

          serviceConfig = {
            ExecStart = "${pkgs.rclone}/bin/rclone --config ${configPath} mount remote:${path} \"${mountpoint}\" --allow-other";
            User = "rclone";
            Type = "simple";
            Restart = "always";
            PermissionsStartOnly = true;
          };
        };
      };
    in mapAttrs' makeService cfg.mounts;
  };
}
