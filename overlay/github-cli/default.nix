{ github-cli }:
github-cli.overrideAttrs (
  oldAttrs: {
    patches = [ ./0001-Make-markdown-rendering-use-light-themes.patch ];
  }
)
