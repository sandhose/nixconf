require'my.options'

require'crates'.setup()
require'trouble'.setup()
require'gitsigns'.setup()
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- TODO
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = false,
  },
}
require'nvim-tree'.setup {
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
  },
}

require'treesitter-context'.setup {
  enable = true,
  max_lines = 10,
  multiline_threshold = 2,
  mode = 'topline',
}

local dap, dapui = require'dap', require'dapui'
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

require'my.completion'
require'my.lsp'
require'my.lualine'
require'my.telescope'
