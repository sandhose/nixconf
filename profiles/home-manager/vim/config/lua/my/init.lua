-- rustaceanvim must be configured before the plugin loads
vim.g.rustaceanvim = function()
  local extension_path = vim.env.HOME .. '/.vscode-insiders/extensions/vadimcn.vscode-lldb-1.10.0/'
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb'
  local this_os = vim.loop.os_uname().sysname;
  liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

  local cfg = require'rustaceanvim.config'
  return {
    server = {
      default_settings = {
        ['rust-analyzer'] = {
          rustfmt = {
            extraArgs = { "+nightly" },
          },

          checkOnSave = {
            command = "clippy",
            extraArgs = { "--no-deps" },
          },

          inlay_hints = {
            bindingModeHints = {
              enable = true,
            },

            lifetimeElisionHints = {
              enable = "always",
            },
            reborrowHints = {
              enable = "always",
            },
          },
          procMacro = {
            ignored = {
              ["async-trait"] = {"async_trait"},
              ["async-graphql"] = {"Object", "Subscription"},
              ["tracing"] = {"instrument"},
              ["tokio"] = {"main", "test"},
            },
          },
        },
      },
    },
    dap = {
      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  }
end

require 'my.options'

require 'crates'.setup()
require 'trouble'.setup()
require 'gitsigns'.setup()
-- require'nvim-treesitter.configs'.setup {
--   highlight = {
--     enable = true,
--   },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       -- TODO
--       init_selection = "gnn",
--       node_incremental = "grn",
--       scope_incremental = "grc",
--       node_decremental = "grm",
--     },
--   },
--   indent = {
--     enable = false,
--   },
-- }
require 'nvim-tree'.setup {
    diagnostics = {
        enable = true,
    },
    update_focused_file = {
        enable = true,
    },
}

require 'treesitter-context'.setup {
    enable = true,
    max_lines = 10,
    multiline_threshold = 2,
    mode = 'topline',
}

local dap, dapui = require 'dap', require 'dapui'
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

require 'my.completion'
require 'my.lsp'
require 'my.lualine'
require 'my.telescope'
