_: {
  home-manager.users.buffet = {
    programs.senpai = {
      enable = true;
      config = {
        addr = "irc.buffet.sh";
        nick = "buffet";
      };
    };
  };
}
