self: super:
let
  sources = import ../nix/sources.nix;
  nixpkgs-unstable = import sources.nixpkgs-unstable {};
in
{
  github-cli = super.callPackage ./github-cli { github-cli = super.github-cli; };
  grimshot = super.callPackage ./grimshot.nix {};
  kak-attach-session = super.callPackage ./kak-attach-session.nix {};

  kakounePlugins = super.kakounePlugins // {
    kak-fzf = super.callPackage ./kak-fzf.nix {};
  };

  nixrl = super.callPackage ./nixrl.nix {};
  rclone = super.callPackage ./rclone.nix { rclone = nixpkgs-unstable.rclone; };
  trup = super.callPackage ./trup.nix {};
}
