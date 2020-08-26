{ pkgs }:
''
  [language.c_cpp]
  filetypes = ["c", "cpp"]
  roots = ["compile_commands.json", ".clangd", ".git"]
  command = "${pkgs.ccls}/bin/ccls"

  [language.latex]
  filetypes = ["latex"]
  roots = [".git"]
  command = "${pkgs.texlab}/bin/texlab"
''
