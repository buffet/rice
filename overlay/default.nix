self: super:
{
  grimshot = super.callPackage ./grimshot.nix { };
  kak-attach-session = super.callPackage ./kak-attach-session.nix { };
}
