self: super:
{
  grimshot = super.callPackage ./grimshot.nix { };
  kak-attach-session = super.callPackage ./kak-attach-session.nix { };

  kakounePlugins = super.kakounePlugins // {
    kak-fzf = super.callPackage ./kak-fzf.nix { };
  };

  nixrl = super.callPackage ./nixrl.nix { };
  trup = super.callPackage ./trup.nix { };
}
