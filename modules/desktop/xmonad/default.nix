{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.desktop.xmonad;
  colors = config.buffet.desktop.colors;

  readDirRec = dir:
    lib.flatten (
      lib.mapAttrsToList
        (
          name: value: let
            path = builtins.toPath ((toString dir) + "/" + name);
          in
            if value == "directory" then readDirRec path else [ path ]
        )
        (builtins.readDir dir)
    );

  generateImports = dir: target:
    builtins.listToAttrs (
      map
        (
          p: lib.nameValuePair
            (target + "/" + (lib.removePrefix ((toString dir) + "/") p))
            { source = p; }
        )
        (lib.filter (lib.hasSuffix ".hs") (map toString (readDirRec dir)))
    );
in
  with lib; {
    options = {
      buffet.desktop.xmonad = {
        enable = mkEnableOption "XMonad window manager";
      };
    };

    config = mkIf cfg.enable {
      buffet.home = {
        home.file = {
          ".xmonad/xmonad.hs".text = let
            xmobarrc = pkgs.writeText "xmobarrc" (import ./xmobarrc.nix { inherit colors; });
          in
            import ./xmonadhs.nix { inherit pkgs colors xmobarrc; };
        } // generateImports ./lib ".xmonad/lib";


        xsession.windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };
    };
  }
