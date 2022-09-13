{lib, ...}: {
  home-manager.users.buffet = {
    programs.newsboat = {
      enable = true;
      autoReload = true;

      extraConfig = ''
        color listnormal          black   white
        color listfocus           white   yellow
        color listnormal_unread   black   white  bold
        color listfocus_unread    white   yellow bold
        color title               white   blue   bold
        color info                yellow  white  bold
        color hint-key            default white  bold
        color hint-keys-delimiter default white
        color hint-separator      default white  bold
        color hint-description    default white
      '';

      urls = lib.mapAttrsToList (title: url: {inherit title url;}) {
        drew = "https://drewdevault.com/blog/index.xml";
        emersion = "https://emersion.fr/blog/atom.xml";
        matklad = "https://matklad.github.io/feed.xml";
        sammyette = "https://sammy.is-a.dev/blog/index.xml";
        xkcd = "https://xkcd.com/rss.xml";
      };
    };
  };
}
