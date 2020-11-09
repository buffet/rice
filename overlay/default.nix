{ config }:
let
  sources = import ../nix/sources.nix;
  nixpkgs-unstable = import sources.nixpkgs-unstable {};
in
(
  self: super:
    rec {
      emacs = nixpkgs-unstable.emacs;
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
      plover_with_plugins = super.callPackage  ./plover_with_plugins.nix { plover = super.plover.dev; };
      plover_retro_stringop = super.python36Packages.callPackage ./plover_retro_stringop.nix { plover = super.plover.dev; };
      rclone = super.callPackage ./rclone.nix { inherit (super) rclone; };
      inherit (nixpkgs-unstable) rust-analyzer;
      trup = super.callPackage ./trup.nix {};
    }
)
