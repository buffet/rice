{ sources ? import ../nix/sources.nix
, nodejs
, vimPlugins
, vimUtils }:

let
  inherit (vimUtils) buildVimPluginFrom2Nix;
in
{
  any-jump = buildVimPluginFrom2Nix {
    name = "any-jump";
    src = sources.any-jump;
  };

  detectindent = buildVimPluginFrom2Nix {
    name = "detectindent";
    src = sources.detectindent;
  };

  fennel-vim = buildVimPluginFrom2Nix {
    name = "fennel-vim";
    src = sources.fennel-vim;
  };

  literate-vim = buildVimPluginFrom2Nix {
    name = "literate-vim";
    src = sources.literate-vim;
  };

  prolog-vim = buildVimPluginFrom2Nix {
    name = "prolog-vim";
    src = sources.prolog-vim;
  };

  vim-openscad = buildVimPluginFrom2Nix {
    name = "vim-openscad";
    src = sources.vim-openscad;
  };

  vim-yoink = buildVimPluginFrom2Nix {
    name = "vim-yoink";
    src = sources.vim-yoink;
  };
}
