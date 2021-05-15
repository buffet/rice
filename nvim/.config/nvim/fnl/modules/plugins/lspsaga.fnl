(module modules.plugins.lspsaga
  {require {saga lspsaga}})

(saga.init_lsp_saga
  {:border_style "round"
   :finder_action_keys
    {:open "<Cr>"
     :vsplit :v
     :split :s
     :quit :q}})
