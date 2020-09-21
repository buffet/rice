{ config }:
let
  sources = import ../nix/sources.nix;
  nixpkgs-unstable = import sources.nixpkgs-unstable {};
in
(
  self: super:
    {
      autotiling = super.callPackage ./autotiling.nix {};
      github-cli = super.callPackage ./github-cli {
        inherit (super) github-cli;
        lighttheme = config.buffet.desktop.colors.lighttheme;
      };

      grimshot = super.callPackage ./grimshot.nix {};
      inherit (nixpkgs-unstable.python38Packages) i3ipc;
      kak-attach-session = super.callPackage ./kak-attach-session.nix {};

      kakounePlugins = super.kakounePlugins // {
        inherit (nixpkgs-unstable.kakounePlugins) kak-fzf;
        kakoune-gdb = super.callPackage ./kakoune-gdb.nix {};
      };

      nixrl = super.callPackage ./nixrl.nix {};
      rclone = super.callPackage ./rclone.nix { inherit (super) rclone; };
      inherit (nixpkgs-unstable) rust-analyzer;
      trup = super.callPackage ./trup.nix {};
    }
)
