{ config }:
let
  sources = import ../nix/sources.nix;
  nixpkgs-unstable = import sources.nixpkgs-unstable {};
in
(
  self: super:
    {

      github-cli = super.callPackage ./github-cli {
        inherit (super) github-cli;
        lighttheme = config.buffet.desktop.colors.lighttheme;
      };

      grimshot = super.callPackage ./grimshot.nix {};
      kak-attach-session = super.callPackage ./kak-attach-session.nix {};

      kakounePlugins = super.kakounePlugins // {
        inherit (nixpkgs-unstable.kakounePlugins) kak-fzf;
      };

      nixrl = super.callPackage ./nixrl.nix {};
      rclone = super.callPackage ./rclone.nix { inherit (super) rclone; };
      inherit (nixpkgs-unstable) rust-analyzer;
      trup = super.callPackage ./trup.nix {};
    }
)
