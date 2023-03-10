{pkgs, ...}: {
  home-manager.users.buffet = {
    home = {
      packages = with pkgs; [
        roswell
        sbcl
      ];

      file.".config/common-lisp/source-registry.conf.d/lisp.conf".text = ''
        (:include (:home "proj" "cl-proj.lisp"))
      '';
    };
  };
}
