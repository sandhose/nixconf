local actions = require'telescope.actions'
local trouble = require'trouble.providers.telescope'

local telescope = require'telescope'
local dressing = require'dressing'

telescope.load_extension'dap'
telescope.setup {
  defaults = {
    layout_config = {
      vertical = {
        width = 100,
      },
    },
    mappings = {
      i = { ['<c-t>'] = trouble.open_with_trouble },
      n = { ['<c-t>'] = trouble.open_with_trouble },
    },
  },
  pickers = {
    find_files = { theme = 'dropdown' },
    live_grep = { theme = 'dropdown' },
    buffers = { theme = 'dropdown' },
    help_tags = { theme = 'dropdown' },
    lsp_definitions = { theme = 'dropdown' },
    lsp_implementations = { theme = 'dropdown' },
    lsp_type_definitions = { theme = 'dropdown' },
    lsp_references = { theme = 'dropdown' },
  },
}

dressing.setup {
  select = {
    telescope = require'telescope.themes'.get_cursor(),
  },
}
