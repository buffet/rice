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
    nixpkgs.overlays = let
      plugins = with pkgs.kakounePlugins; [
        kak-auto-pairs
        kak-fzf
      ];
    in [(self: super: {
      kakoune = super.wrapKakoune super.kakoune-unwrapped {
        configure = { inherit plugins; };
      };
    })];

    buffet.home = {
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
              effect = "<a-;><a-gt>";
              mode = "insert";
            }
            {
              key = "w";
              effect = ": w<ret>";
              docstring = "save";
              mode = "user";
            }
            {
              key = "f";
              effect = ": fzf-mode<ret>";
              docstring = "fzf";
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
