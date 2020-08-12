self: super:
{
  grimshot = super.callPackage ./grimshot.nix { };
  kak-attach-session = super.callPackage ./kak-attach-session.nix { };

  kakounePlugins = super.kakounePlugins // {
    kak-auto-pairs = super.callPackage ./kak-auto-pairs.nix { };
    kak-fzf = super.callPackage ./kak-fzf.nix { };
    kak-prelude = super.callPackage ./kak-prelude.nix { };
  };

  nixrl = super.callPackage ./nixrl.nix { };
  trup = super.callPackage ./trup.nix { };
}
