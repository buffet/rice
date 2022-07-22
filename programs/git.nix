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

        s = "status -s";
        co = "checkout";
        cob = "checkout -b";
      };

      extraConfig = {
        init = {
          defaultBranch = "master";
        };
      };
    };
  };
}
