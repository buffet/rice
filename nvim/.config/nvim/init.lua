require 'keybinds'
require 'options'

vim.defer_fn(function()
  require 'plugins'
end, 0)
