local _0_0
do
  local name_0_ = "modules.keybinds"
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
    return {require("aniseed.nvim"), require("utils"), require("which-key")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {nvim = "aniseed.nvim", utils = "utils", wk = "which-key"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local nvim = _local_0_[1]
local utils = _local_0_[2]
local wk = _local_0_[3]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "modules.keybinds"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
local cmd
do
  local v_0_
  do
    local v_0_0
    local function cmd0(s, desc)
      return {("<cmd>" .. s .. "<cr>"), desc}
    end
    v_0_0 = cmd0
    _0_0["cmd"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["cmd"] = v_0_
  cmd = v_0_
end
nvim.command("let g:mapleader = \"\\<Space>\"")
utils.keymap("i", "<C-Space>", "compe#complete()", {expr = true})
utils.keymap("i", "<Esc>", "compe#close('<Esc>')", {expr = true})
utils.keymap("i", "kj", "<Esc>")
utils.keymap("v", "<", "<gv")
utils.keymap("v", ">", ">gv")
utils.keymap("n", "<C-h>", "<C-w>h")
utils.keymap("n", "<C-j>", "<C-w>j")
utils.keymap("n", "<C-k>", "<C-w>k")
utils.keymap("n", "<C-l>", "<C-w>l")
wk.setup({})
return wk.register({[":"] = cmd("Telescope commands", "search commands"), ["<Space>"] = cmd("Telescope find_files", "find file"), b = cmd("Telescope buffers", "select buffer"), l = {name = "+lsp"}, r = cmd("Telescope live_grep", "ripgrep"), t = {g = cmd("Goyo", "goyo"), i = cmd("IndentGuidesToggle", "indent guides"), l = cmd("Limelight!!", "limelight"), name = "+toggle", r = cmd("RainbowParentheses!!", "rainbow parens")}, w = cmd("w", "save file")}, {prefix = "<Leader>"})