(module modules.plugins.compe
  {require {compe compe}})

(compe.setup
  {:enabled true
   :autocomplete true
   :debug false
   :min_length 2
   :preselect "enable"
   :documentation true
   :source {:path true
            :buffer true
            :calc true
            :nvim_lsp true
            :nvim_lua true
            :conjure true}})
