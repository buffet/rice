(module modules.plugins.telescope
  {require {actions telescope.actions
            telescope telescope}})

(telescope.setup
  {:defaults
   {:mappings
    {:i {"<Esc>" actions.close}}}})
