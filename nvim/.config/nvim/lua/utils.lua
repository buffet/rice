local _0_0
do
  local name_0_ = "utils"
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
    return {require("aniseed.core"), require("aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "aniseed.core", nvim = "aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local nvim = _local_0_[2]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "utils"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
local contains_3f
do
  local v_0_
  do
    local v_0_0
    local function contains_3f0(list, elem)
      local function _2_(_241)
        return (elem == _241)
      end
      do local _ = a.some(_2_, list) end
      return false
    end
    v_0_0 = contains_3f0
    _0_0["contains?"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["contains?"] = v_0_
  contains_3f = v_0_
end
local filter_table
do
  local v_0_
  do
    local v_0_0
    local function filter_table0(f, t)
      local tbl_0_ = {}
      for k, v in pairs(t) do
        local _2_0, _3_0 = nil, nil
        if f(k, v) then
          _2_0, _3_0 = k, v
        else
        _2_0, _3_0 = nil
        end
        if ((nil ~= _2_0) and (nil ~= _3_0)) then
          local k_0_ = _2_0
          local v_0_1 = _3_0
          tbl_0_[k_0_] = v_0_1
        end
      end
      return tbl_0_
    end
    v_0_0 = filter_table0
    _0_0["filter-table"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["filter-table"] = v_0_
  filter_table = v_0_
end
local without_keys
do
  local v_0_
  do
    local v_0_0
    local function without_keys0(keys, t)
      local function _2_(_241)
        return not contains_3f(keys, _241)
      end
      return filter_table(_2_, t)
    end
    v_0_0 = without_keys0
    _0_0["without-keys"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["without-keys"] = v_0_
  without_keys = v_0_
end
local keymap
do
  local v_0_
  do
    local v_0_0
    local function keymap0(mode, from, to, _3fopts)
      local full_opts = without_keys({"buffer"}, a.merge({noremap = true, silent = true}, (_3fopts or {})))
      local function _2_()
        local res_0_ = (_3fopts).buffer
        return (res_0_ and res_0_)
      end
      if (_3fopts and _2_()) then
        return nvim.buf_set_keymap(0, mode, from, to, full_opts)
      else
        return nvim.set_keymap(mode, from, to, full_opts)
      end
    end
    v_0_0 = keymap0
    _0_0["keymap"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["keymap"] = v_0_
  keymap = v_0_
end
local highlight
do
  local v_0_
  do
    local v_0_0
    local function highlight0(groups, colset)
      local groups0
      if a["string?"](groups) then
        groups0 = {groups}
      else
        groups0 = groups
      end
      local opts = a.merge({bg = "NONE", fg = "NONE", gui = "NONE"}, colset)
      for _, group in ipairs(groups0) do
        nvim.command(("hi!" .. group .. " guifg='" .. opts.fg .. "' guibg='" .. opts.bg .. "' gui='" .. opts.gui .. "'"))
      end
      return nil
    end
    v_0_0 = highlight0
    _0_0["highlight"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["highlight"] = v_0_
  highlight = v_0_
end
return nil