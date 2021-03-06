{ pkgs }:
''
  [language.c_cpp]
  filetypes = ["c", "cpp"]
  roots = ["compile_commands.json", ".ccls-root", ".git"]
  command = "${pkgs.ccls}/bin/ccls"
  args = ["--init={\"completion\":{\"detailedLabel\":false}}"]

  [language.latex]
  filetypes = ["latex"]
  roots = [".git"]
  command = "${pkgs.texlab}/bin/texlab"

  [language.python]
  filetypes = ["python"]
  roots = ["requirements.txt", "setup.py", ".git", ".hg"]
  command = "${pkgs.python37Packages.python-language-server}/bin/pyls"
  offset_encoding = "utf-8"

  [language.rust]
  filetypes = ["rust"]
  roots = ["Cargo.toml"]
  command = "${pkgs.rust-analyzer}/bin/rust-analyzer"

  [language.nix]
  filetypes = ["nix"]
  roots = [".git"]
  command = "${pkgs.rnix-lsp}/bin/rnix-lsp"
''
