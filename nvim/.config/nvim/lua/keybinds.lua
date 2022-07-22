vim.g.mapleader = ' '

vim.keymap.set('i', 'kj', '<Esc>')

-- better defaults for indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- telescope
--[[
vim.keymap.set('n', 'f', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', 'r', '<cmd>Telescope live_grep<cr>')
--]]

-- lsp
vim.keymap.set('n', '<leader>lr', '<cmd>Lspsaga rename<cr>', { silent = true })
--vim.keymap.set('n', '<leader>lg', '<cmd>Lspsaga <cr>', { silent = true })

-- misc
vim.keymap.set('n', '<leader>s', '<cmd>w<cr>', { silent = true })
