{pkgs, ...}: {
  home-manager.users.buffet = {
    home = {
      packages = with pkgs; [
        sbcl
      ];

      file.".config/common-lisp/source-registry.conf.d/lisp.conf".text = ''
        (:tree "/home/buffet/proj")
      '';
    };
  };
}
