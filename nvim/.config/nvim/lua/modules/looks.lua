local _0_0
do
  local name_0_ = "modules.looks"
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
    return {require("aniseed.nvim"), require("utils")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {nvim = "aniseed.nvim", utils = "utils"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local nvim = _local_0_[1]
local utils = _local_0_[2]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "modules.looks"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
local colors
do
  local v_0_
  do
    local v_0_0 = {bright = {black = "#002b36", blue = "#839496", cyan = "#93a1a1", green = "#586e75", magenta = "#6c71c4", red = "#cb4b16", white = "#fdf6e3", yellow = "#657b83"}, normal = {black = "#07e642", blue = "#268bd2", cyan = "#2aa198", green = "#859900", magenta = "#d33682", red = "#dc322f", white = "#eee8d5", yellow = "#b58900"}, primary = {background = "#fdf6e3", foreground = "#586e75"}}
    _0_0["colors"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["colors"] = v_0_
  colors = v_0_
end
nvim.o.termguicolors = true
nvim.o.background = "light"
nvim.g.lightline = {colorscheme = "solarized"}
nvim.o.fillchars = (nvim.o.fillchars .. "vert:\226\148\130")
nvim.command("colorscheme NeoSolarized")
utils.highlight("Comment", {gui = "italic"})
utils.highlight("ExtraWhitespace", {bg = colors.normal.red})
nvim.command("match ExtraWhitespace /\\s\\+$/")
return utils.highlight({"LineNr", "SignColumn", "VertSplits"}, {bg = colors.primary.background})