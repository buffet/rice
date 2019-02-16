# dotfiles

## Warning

This readme is probably outdated. That said I need to get rid of the hardcoded dotdir path.

## Disclaimer
This isn't really made for others to use -- it's actually just a backup/way of synchronizing.

Feel free to do what you want with it.

## IMPORTANT

Even though this is called rice, be sure to clone it as dotfiles, as I think some of the stuff depends on it.

## NOTE

This is made for NixOS, as I'm using that. This means that most stuff here is probably useless for your config (apart from the values). To use this symlink `nixos` to `/etc/nixos` and `home-manager/.config/nixpkgs/home.nix` to `~/.config/home-manager/nixpkgs/home.nix` and run

```
# nixos-rebuild switch
$ home-manager switch
```

GLHF
