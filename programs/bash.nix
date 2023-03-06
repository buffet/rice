{pkgs, ...}: let
  inputrc = pkgs.writeText "inputrc" ''
    set completion-ignore-case on
  '';
in {
  home-manager.users.buffet = {
    home.sessionVariables = {
      INPUTRC = inputrc;
    };

    programs.bash = {
      enable = true;
      historyControl = ["erasedups" "ignorespace"];

      shellAliases = {
        "cd.." = "cd ..";
        ch = "ssh -t irc.buffet.sh -- screen -r weechat";
        htop = "htop -t";
        mkdir = "mkdir -p";
        rg = "rg -S";
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
                0) PS1='\[\e[34m\]; \[\e[0m\]' ;;
                *) PS1='\[\e[31m\]; \[\e[0m\]' ;;
            esac
        }
        PROMPT_COMMAND="__prompt"

        bind '"\C-o": "\C-a\C-k fg; if [[ $? == 1 ]]; then nvim; fi\n"'
        bind '"\e\C-m": "\C-e | nvim\C-m"'
      '';
    };
  };
}
