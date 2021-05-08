(module modules.keybinds
  {require {nvim aniseed.nvim
            utils utils
            wk which-key}})

(defn cmd [s desc]
  [(.. "<cmd>" s "<cr>") desc])

(nvim.command "let g:mapleader = \"\\<Space>\"")

;; TODO: look into compe
(utils.keymap :i "<C-Space>" "compe#complete()" {:expr true})
(utils.keymap :i "<Esc>" "compe#close('<Esc>')" {:expr true})

(utils.keymap :i :kj "<Esc>")

(utils.keymap :v "<" "<gv")
(utils.keymap :v ">" ">gv")

(utils.keymap :n "<C-h>" "<C-w>h")
(utils.keymap :n "<C-j>" "<C-w>j")
(utils.keymap :n "<C-k>" "<C-w>k")
(utils.keymap :n "<C-l>" "<C-w>l")

(wk.setup {})
(wk.register
  {"<Space>" (cmd "Telescope find_files"  "find file")
   :r        (cmd "Telescope live_grep"   "ripgrep")
   :b        (cmd "Telescope buffers"     "select buffer")
   :w        (cmd "w"                     "save file")
   ":"       (cmd "Telescope commands"    "search commands")

   :t {:name "+toggle"
        :i   (cmd "IndentGuidesToggle"    "indent guides")
        :r   (cmd "RainbowParentheses!!"  "rainbow parens")
        :g   (cmd "Goyo"                  "goyo")
        :l   (cmd "Limelight!!"           "limelight")}

   ;; TODO: lsp binds
   :l {:name "+lsp"}}

  {:prefix "<Leader>"})
