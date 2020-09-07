{ lib
, github-cli
, lighttheme ? false
}:
github-cli.overrideAttrs (
  oldAttrs: {
    patches = lib.optional lighttheme ./0001-Make-markdown-rendering-use-light-themes.patch;
  }
)
