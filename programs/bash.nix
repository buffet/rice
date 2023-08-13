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
        update = let
          change-message = pkgs.writeScript "change-commit-message" ''
            #!/bin/sh
            sed -i '1s/.*/chore: update/' "$1"
          '';
        in "nix flake update --commit-lock-file && EDITOR=${change-message} git commit --amend";
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
        PS0='\[\e[0m\]'
        PS1='\[\e[1m\]      '

        bind '"\C-o": "\C-a\C-k fg; if [[ $? == 1 ]]; then nvim; fi\n"'
        bind '"\e\C-m": "\C-e | nvim\C-m"'
      '';
    };
  };
}
