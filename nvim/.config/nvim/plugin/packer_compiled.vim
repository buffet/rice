" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/home/buffet/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/buffet/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/buffet/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/buffet/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/buffet/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  NeoSolarized = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/NeoSolarized"
  },
  aniseed = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/aniseed"
  },
  ["ats-vim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/ats-vim"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["compe-conjure"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/compe-conjure"
  },
  conjure = {
    config = { "vim.g['conjure#client#fennel#aniseed#aniseed_module_prefix'] = 'aniseed.'" },
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/conjure"
  },
  detectindent = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/detectindent"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/goyo.vim"
  },
  ["lightline.vim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/lightline.vim"
  },
  ["limelight.vim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/limelight.vim"
  },
  ["lsp-trouble.nvim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim.lua"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/nvim.lua"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rainbow_parentheses.vim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/rainbow_parentheses.vim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/rust-tools.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/rust.vim"
  },
  tabular = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-css-color"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/vim-css-color"
  },
  ["vim-exchange"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/vim-exchange"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-indent-guides"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/vim-indent-guides"
  },
  ["vim-parinfer"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/vim-parinfer"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-slash"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/vim-slash"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/vim-smoothie"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/vim-sneak"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/buffet/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time("Defining packer_plugins", false)
-- Config for: conjure
time("Config for conjure", true)
vim.g['conjure#client#fennel#aniseed#aniseed_module_prefix'] = 'aniseed.'
time("Config for conjure", false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
