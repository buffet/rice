{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.programs.kak;
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
              ];
            };
          }
        )
      ];

      buffet.home = {
        home.sessionVariables = { EDITOR = "kak"; };

        home.file.".config/kak-lsp/kak-lsp.toml".text = pkgs.callPackage ./kak-lsp.nix {};

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

            numberLines = {
              enable = true;
              relative = true;
              highlightCursor = true;
            };

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

            keyMappings = [
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
                key = "f";
                effect = ": fzf-mode<ret>";
                docstring = "fzf";
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
                effect = "<a-!>wl-paste<ret>";
                docstring = "paste (after)";
                mode = "user";
              }
              {
                key = "P";
                effect = "!wl-paste<ret>";
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
                effect = "<a-|>wl-copy<ret>";
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

            # lsp
            eval %sh{ ${pkgs.kak-lsp}/bin/kak-lsp --kakoune -s $kak_session }
            lsp-enable
          '';
        };
      };
    };
  }
