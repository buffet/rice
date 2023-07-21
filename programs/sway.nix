{
  pkgs,
  lib,
  ...
}: {
  programs.sway.enable = true;

  home-manager.users.buffet = {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      xwayland = false;

      config = let
        browser = "firefox";
        mod = "Mod4";
        terminal = "foot";
        theme = import ../theme.nix;

        makeWorkspaceBinds = num: let
          ws = toString num;
        in {
          "${mod}+${ws}" = "workspace ${ws}";
          "${mod}+Shift+${ws}" = "move container to workspace ${ws}";
        };

        joinAttrSets = builtins.foldl' (x: y: x // y) {};

        statusCommand = pkgs.writeScript "status_command" ''
          #!/bin/sh

          while :; do
              energy_full=
              energy_now=
              charge=

              for bat in /sys/class/power_supply/*/capacity; do
                  bat="''${bat%/*}"
                  read -r full < $bat/energy_full
                  read -r now < $bat/energy_now
                  energy_full=$((energy_full + full))
                  energy_now=$((energy_now + now))
              done

              if cat /sys/class/power_supply/*/status | grep -q Charging; then
                  charge=+
              fi

              printf '%s %s ' "$charge$((energy_now * 100 / energy_full))%" "$(date +'%H:%M')"

              sleep 3
          done
        '';
      in {
        modifier = mod;
        window.border = 1;
        focus.followMouse = true;
        fonts = {
          names = [theme.font.family];
          style = "Regular";
          size = theme.font.size * 1.0;
        };

        gaps = {
          inner = 8;
          outer = 0;
        };

        input."*" = {
          xkb_layout = "us";
          xkb_options = "compose:prsc";
        };

        output."*" = {bg = "${theme.primary.background} solid_color";};

        floating.titlebar = false;
        window.titlebar = false;

        colors = with theme; rec {
          focused = rec {
            inherit (wm.focused) border text;
            inherit (primary) background;
            indicator = border;
            childBorder = border;
          };

          unfocused = rec {
            inherit (wm.unfocused) border text;
            inherit (primary) background;
            indicator = border;
            childBorder = border;
          };

          focusedInactive = unfocused;
        };

        keybindings = let
          swaylockConf = pkgs.writeText "swaylock.conf" ''
            ignore-empty-password
            color=${theme.primary.background}
            bs-hl-color=${theme.normal.red}
            caps-lock-bs-hl-color=${theme.normal.red}
            caps-lock-key-hl-color=${theme.bright.green}
            inside-color=${theme.primary.background}
            inside-clear-color=${theme.normal.yellow}
            inside-caps-lock-color=${theme.primary.background}
            inside-ver-color=${theme.normal.blue}
            inside-wrong-color=${theme.normal.red}
            key-hl-color=${theme.bright.green}
            ring-color=${theme.normal.green}
            ring-clear-color=${theme.normal.yellow}
            ring-caps-lock-color=${theme.bright.yellow}
            ring-ver-color=${theme.bright.blue}
            ring-wrong-color=${theme.bright.red}
          '';
        in
          {
            "${mod}+Shift+c" = "kill";
            "${mod}+Control+r" = "reload";
            "${mod}+Shift+e" = "exit";

            "${mod}+Shift+Return" = "exec ${terminal}";
            "${mod}+i" = "exec ${browser}";
            "${mod}+Shift+y" = "exec ${pkgs.swaylock}/bin/swaylock -C '${swaylockConf}'";
            "${mod}+z" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 1%-";
            "${mod}+x" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 1%+";
            "${mod}+Shift+z" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
            "${mod}+Shift+x" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 5%+";

            "${mod}+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy window";
            "${mod}+Shift+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy active";

            "${mod}+o" = "splith";
            "${mod}+u" = "splitv";

            "${mod}+s" = "layout stacking";
            "${mod}+t" = "layout tabbed";
            "${mod}+e" = "layout toggle split";
            "${mod}+f" = "fullscreen";

            "${mod}+h" = "focus left";
            "${mod}+j" = "focus down";
            "${mod}+k" = "focus up";
            "${mod}+l" = "focus right";

            "${mod}+Left" = "focus left";
            "${mod}+Down" = "focus down";
            "${mod}+Up" = "focus up";
            "${mod}+Right" = "focus right";

            "${mod}+Shift+h" = "move left";
            "${mod}+Shift+j" = "move down";
            "${mod}+Shift+k" = "move up";
            "${mod}+Shift+l" = "move right";

            "${mod}+Ctrl+h" = "resize grow left 10 px or 10 ppt";
            "${mod}+Ctrl+j" = "resize grow down 10 px or 10 ppt";
            "${mod}+Ctrl+k" = "resize grow up 10 px or 10 ppt";
            "${mod}+Ctrl+l" = "resize grow right 10 px or 10 ppt";

            "${mod}+space" = "focus mode_toggle";
            "${mod}+a" = "focus parent";

            "${mod}+Shift+space" = "floating toggle";
          }
          // (joinAttrSets (map makeWorkspaceBinds (lib.range 1 9)));

        seat."*" = {hide_cursor = "when-typing enable";};

        bars = [
          {
            position = "top";
            fonts = {
              names = [theme.font.family];
              style = "Regular";
              size = theme.font.size * 1.0;
            };
            statusCommand = "${statusCommand}";

            colors = with theme; {
              statusline = primary.foreground;
              inherit (primary) background;

              focusedWorkspace = {
                inherit (primary) background;
                inherit (wm.focused) text;
                inherit (wm.focused) border;
              };

              inactiveWorkspace = {
                inherit (primary) background;
                inherit (wm.unfocused) text;
                border = primary.background;
              };
            };

            extraConfig = ''
              gaps 5
            '';
          }
        ];
      };

      extraConfig = ''
        for_window [title="leftovers"] floating enable
      '';
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
