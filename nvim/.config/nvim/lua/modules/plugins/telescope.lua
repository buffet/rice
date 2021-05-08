local _0_0
do
  local name_0_ = "modules.plugins.telescope"
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
    return {require("telescope.actions"), require("telescope")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {actions = "telescope.actions", telescope = "telescope"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local actions = _local_0_[1]
local telescope = _local_0_[2]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "modules.plugins.telescope"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
return telescope.setup({defaults = {i = {["<Esc>"] = actions.close}}})