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

require'my.completion'
require'my.dap'
require'my.lsp'
require'my.lualine'
require'my.telescope'
