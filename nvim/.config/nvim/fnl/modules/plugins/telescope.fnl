(module modules.plugins.telescope
  {require {actions telescope.actions
            telescope telescope}})

(telescope.setup
  {:defaults
   {:i {"<Esc>" actions.close}}})
