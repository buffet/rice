{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.programs.bash;

  inputrc = pkgs.writeText "inputrc" ''
    set completion-ignore-case on
  '';
in
  with lib; {
    options = {
      buffet.programs.bash = {
        enable = mkEnableOption "bash";
      };
    };

    config = mkIf cfg.enable {
      buffet.home = {
        home.sessionVariables = {
          INPUTRC = inputrc;
        };

        programs.bash = {
          enable = true;
          enableAutojump = true;
          historyControl = [ "erasedups" "ignorespace" ];
          historyFile = "$HOME/.cache/bash_history";

          shellAliases = {
            htop = "htop -t";
            mkdir = "mkdir -p";
            p = "$(history -p !!)";
            rg = "rg -S";
            t = "cd /tmp";
          };

          shellOptions = [
            "cdspell"
            "checkjobs"
            "extglob"
            "globstar"
            "histappend"
            "nocaseglob"
          ];

          initExtra = ''
            __prompt() {
                case $? in
                    0) PS1='\[\e[36m\]>> \[\e[0m\]' ;;
                    *) PS1='\[\e[31m\]>> \[\e[0m\]' ;;
                esac
            }
            PROMPT_COMMAND=__prompt
          '';
        };
      };
    };
  }
