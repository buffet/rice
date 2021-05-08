(module modules.looks
  {require {nvim aniseed.nvim
            utils utils}})

(def colors
  {:primary
    {:background "#fdf6e3"
     :foreground "#586e75"}

   :normal
    {:black      "#07e642"
     :red        "#dc322f"
     :green      "#859900"
     :yellow     "#b58900"
     :blue       "#268bd2"
     :magenta    "#d33682"
     :cyan       "#2aa198"
     :white      "#eee8d5"}

   :bright
    {:black      "#002b36"
     :red        "#cb4b16"
     :green      "#586e75"
     :yellow     "#657b83"
     :blue       "#839496"
     :magenta    "#6c71c4"
     :cyan       "#93a1a1"
     :white      "#fdf6e3"}})

(set nvim.o.termguicolors true)
(set nvim.o.background "light")
(set nvim.g.lightline {:colorscheme "solarized"})
(set nvim.o.fillchars (.. nvim.o.fillchars "vert:│"))

(nvim.command "colorscheme NeoSolarized")
(utils.highlight "Comment" {:gui "italic"})

(utils.highlight "ExtraWhitespace" {:bg colors.normal.red})
(nvim.command "match ExtraWhitespace /\\s\\+$/")

(utils.highlight 
 ["LineNr"
  "SignColumn"
  "VertSplits"]
 {:bg colors.primary.background})
