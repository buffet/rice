{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.programs.kak;
  sessionType = config.buffet.desktop.sessionType;
in
  with lib; {
    options = {
      buffet.programs.kak = {
        enable = mkEnableOption "kakoune";
      };
    };

    config = mkIf cfg.enable {
      nixpkgs.overlays = [
        (
          self: super: {
            kakoune = super.wrapKakoune super.kakoune-unwrapped {
              configure.plugins = with pkgs.kakounePlugins; [
                kak-fzf
                kakoune-gdb
              ];
            };
          }
        )
      ];

      buffet.home = {
        home = {
          sessionVariables = { EDITOR = "kak"; };
          file.".config/kak-lsp/kak-lsp.toml".text = pkgs.callPackage ./kak-lsp.nix {};

          packages = with pkgs; [
            gdb # required by kakoune-gdb
            socat # required by kakoune-gdb
          ];
        };

        programs.bash.shellAliases = {
          k = "${pkgs.kak-attach-session}/bin/kak-attach-session";
        };


        programs.kakoune = {
          enable = true;

          config = {
            indentWidth = 4;
            tabStop = 4;
            showMatching = true;
            wrapLines.enable = true;

            ui.assistant = "cat";
            ui.enableMouse = true;

            hooks = [
              {
                name = "BufCreate";
                option = ".*\.nix";
                commands = ''
                  set buffer indentwidth 2
                '';
              }
              {
                name = "ModuleLoaded";
                option = "fzf";
                once = true;
                commands = ''
                  set-option global fzf_grep_command rg
                  set-option global fzf_file_command rg
                  set-option global fzf_implementation "${pkgs.fzf}/bin/fzf"
                '';
              }
            ];

            keyMappings = let
              sysCopy =
                if sessionType == "wayland"
                then "wl-copy"
                else "xclip -i -sel c";
              sysPaste =
                if sessionType == "wayland"
                then "wl-paste"
                else "xclip -o -sel c";
            in [
              {
                key = "<tab>";
                effect = "<a-;><a-gt>";
                mode = "insert";
              }
              {
                key = "<s-tab>";
                effect = "<a-;><a-lt>";
                mode = "insert";
              }
              {
                key = "a";
                effect = ": lsp-code-actions<ret>";
                docstring = "Show lsp actions";
                mode = "user";
              }
              {
                key = "c";
                effect = ": comment-line<ret>";
                docstring = "Comment line";
                mode = "user";
              }
              {
                key = "f";
                effect = ": fzf-mode<ret>";
                docstring = "fzf";
                mode = "user";
              }
              {
                key = "g";
                effect = ": enter-user-mode gdb<ret>";
                docstring = "gdb";
                mode = "user";
              }
              {
                key = "l";
                effect = ": enter-user-mode lsp<ret>";
                docstring = "lsp";
                mode = "user";
              }
              {
                key = "p";
                effect = "<a-!>${sysPaste}<ret>";
                docstring = "paste (after)";
                mode = "user";
              }
              {
                key = "P";
                effect = "!${sysPaste}<ret>";
                docstring = "paste (before)";
                mode = "user";
              }
              {
                key = "r";
                effect = ": lsp-highlight-references<ret>";
                docstring = "highlight refs";
                mode = "user";
              }
              {
                key = "w";
                effect = ": w<ret>";
                docstring = "save";
                mode = "user";
              }
              {
                key = "y";
                effect = "<a-|>${sysCopy}<ret>";
                docstring = "yank to system clipboard";
                mode = "user";
              }
              {
                key = ",";
                effect = ": lsp-hover<ret>";
                docstring = "lsp-hover";
                mode = "user";
              }
            ];
          };

          extraConfig = ''
            # highlight trailing whitespace
            add-highlighter global/ regex '[ \t]+$' 0:red,red

            # load project local config
            try %{ source .kakrc.local }

            # gdb user-mode
            declare-user-mode gdb
            map global gdb b -docstring "breakpoint" ": gdb-toggle-breakpoint<ret>"
            map global gdb c -docstring "continue" ": gdb-continue-or-run<ret>"
            map global gdb f -docstring "finish" ": gdb-finish<ret>"
            map global gdb n -docstring "next" ": gdb-next<ret>"
            map global gdb p -docstring "print" ": gdb-print<ret>"
            map global gdb q -docstring "quit" ": gdb-session-stop<ret>"
            map global gdb r -docstring "run" ": gdb-run<ret>"
            map global gdb s -docstring "step" ": gdb-step<ret>"
            map global gdb w -docstring "new session" ": gdb-session-new<ret>"

            # lsp
            eval %sh{ ${pkgs.kak-lsp}/bin/kak-lsp --kakoune -s $kak_session }
            lsp-enable
          '';
        };
      };
    };
  }
