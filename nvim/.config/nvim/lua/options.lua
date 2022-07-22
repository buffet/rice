local function opts(os)
  for k,v in pairs(os) do
    vim.opt[k] = v
  end
end

opts {
  termguicolors = true,
  background = 'light',

  undodir = vim.env['XDG_CACHE_HOME'] .. '/vim-undodir',
  undofile = true,

  encoding = 'utf-8',
  hidden = true,
  mouse = 'a',
  hlsearch = true,
  incsearch = true,
  inccommand = 'nosplit',
  ignorecase = true,
  smartcase = true,
  laststatus = 2,
  lazyredraw = true,
  splitbelow = true,
  splitright = true,
  matchtime = 2,
  showmatch = true,
  wrap = false,
  writebackup = false,
  swapfile = false,
  showmode = false,
  updatetime = 250,
  signcolumn = 'yes',
  shiftwidth = 4,
  tabstop = 4,
  shiftround = true,
  autoindent = true,
  smartindent = true,
  expandtab = true,

  colorcolumn = '+1',
  cursorline = true,
  signcolumn = 'yes',
}
