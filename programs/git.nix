_: {
  home-manager.users.buffet = {
    programs.git = {
      enable = true;
      userEmail = "niclas@countingsort.com";
      userName = "buffet";
      difftastic = {
        enable = true;
        background =
          if (import ../theme.nix).light
          then "light"
          else "dark";
      };

      aliases = {
        a = "add";
        b = "branch";
        c = "commit --verbose";
        m = "commit --amend --verbose";

        d = "diff";
        ds = "diff --stat";
        dc = "diff --cached";

        l = "log";
        s = "status -s";
        co = "checkout";
        cob = "checkout -b";
      };

      signing = {
        key = "EBAC355935FD7382";
        signByDefault = true;
      };

      extraConfig = {
        init = {
          defaultBranch = "master";
        };
      };
    };
  };
}
