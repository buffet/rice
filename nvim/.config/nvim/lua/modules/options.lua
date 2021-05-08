local _0_0
do
  local name_0_ = "modules.options"
  local module_0_
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local autoload = (require("aniseed.autoload")).autoload
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {require("aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {nvim = "aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local nvim = _local_0_[1]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "modules.options"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
nvim.o.mouse = "a"
nvim.o.undodir = (nvim.env.XDG_CACHE_HOME .. "/vim-undodir")
nvim.o.undofile = true
nvim.o.shortmess = (nvim.o.shortmess .. "c")
nvim.o.hidden = true
nvim.o.encoding = "utf-8"
nvim.o.hlsearch = true
nvim.o.incsearch = true
nvim.o.inccommand = "nosplit"
nvim.o.ignorecase = true
nvim.o.smartcase = true
nvim.o.completeopt = "longest,menuone,preview"
nvim.o.laststatus = 2
nvim.o.lazyredraw = true
nvim.o.splitbelow = true
nvim.o.splitright = true
nvim.o.matchtime = 2
nvim.o.showmatch = true
nvim.o.wrap = false
nvim.o.writebackup = false
nvim.o.showmode = false
nvim.o.updatetime = 250
nvim.o.signcolumn = "yes"
nvim.o.shiftwidth = 4
nvim.o.tabstop = 4
nvim.o.backspace = "indent,eol,start"
nvim.o.shiftround = true
nvim.o.autoindent = true
nvim.o.smartindent = true
nvim.o.expandtab = true
nvim.wo.cursorline = true
return nil