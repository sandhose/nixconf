-- LSP config, here we go!
local nvim_lsp = require'lspconfig'

require'fidget'.setup {}

-- Advertise snippets support
local capabilities = require'cmp_nvim_lsp'.default_capabilities()
capabilities.offsetEncoding = { 'utf-16' }
capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require'neotest'.setup {
  adapters = {
    require'rustaceanvim.neotest'
  },
}

require("hover").setup {
  init = function()
    require("hover.providers.lsp")
    require('hover.providers.gh')
    require('hover.providers.gh_user')
  end,
  preview_opts = {
    border = 'single'
  },
  -- Whether the contents of a currently open hover window should be moved
  -- to a :h preview-window when pressing the hover keymap.
  preview_window = false,
  title = true,
  mouse_providers = {
    'LSP'
  },
  mouse_delay = 1000
}

-- Setup keymaps
vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, {desc = "hover.nvim (previous source)"})
vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end, {desc = "hover.nvim (next source)"})

-- Mouse support
vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
vim.o.mousemoveevent = true

-- Keybindings
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(args.buf, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(args.buf, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    buf_set_keymap('n', 'gD', '', {
      noremap = true,
      silent = true,
      desc = 'Jump to definition',
      callback = function() 
        vim.lsp.buf.definition()
      end,
    })

    buf_set_keymap('n', 'gd', '', {
      noremap = true,
      silent = true,
      desc = 'Go to definition',
      callback = function() 
        require'telescope.builtin'.lsp_definitions()
      end,
    })

    buf_set_keymap('n', 'gi', '', {
      noremap = true,
      silent = true,
      desc = 'Go to implementation',
      callback = function() 
        require('telescope.builtin').lsp_implementations()
      end,
    })

    buf_set_keymap('n', '<C-k>', '', {
      noremap = true,
      silent = true,
      desc = 'Show signature help',
      callback = function() 
        vim.lsp.buf.signature_help()
      end,
    })

    buf_set_keymap('n', '<leader>D', '', {
      noremap = true,
      silent = true,
      desc = 'Go to type definition',
      callback = function() 
        require'telescope.builtin'.lsp_type_definitions()
      end,
    })

    buf_set_keymap('n', '<leader>rn', '', {
      noremap = true,
      silent = true,
      desc = 'Rename',
      callback = function() 
        vim.lsp.buf.rename()
      end,
    })

    buf_set_keymap('n', '<leader>ca', '', {
      noremap = true,
      silent = true,
      desc = 'Show code actions',
      callback = function() 
        vim.lsp.buf.code_action()
      end,
    })

    buf_set_keymap('n', 'gr', '', {
      noremap = true,
      silent = true,
      desc = 'Show references',
      callback = function() 
        require'telescope.builtin'.lsp_references()
      end,
    })

    buf_set_keymap('n', '<leader>e', '', {
      noremap = true,
      silent = true,
      desc = 'Show line diagnostics',
      callback = function() 
        vim.lsp.diagnostic.show_line_diagnostics()
      end,
    })

    buf_set_keymap('n', '[d', '', {
      noremap = true,
      silent = true,
      desc = 'Previous trouble',
      callback = function() 
        require'trouble'.previous({skip_groups = true, jump = true})
      end,
    })

    buf_set_keymap('n', ']d', '', {
      noremap = true,
      silent = true,
      desc = 'Next trouble',
      callback = function() 
        require'trouble'.next({skip_groups = true, jump = true})
      end,
    })

    buf_set_keymap('n', '<leader>q', '', {
      noremap = true,
      silent = true,
      desc = 'Trouble loclist',
      callback = function() 
        require'trouble'.loclist()
      end,
    })

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
      buf_set_keymap('n', '<leader>f', '', {
        noremap = true,
        silent = true,
        desc = 'Format buffer',
        callback = function()
          vim.lsp.buf.format { async = true }
        end,
      })

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      buf_set_keymap('v', '<leader>f', '', {
        noremap = true,
        silent = true,
        desc = 'Format range',
        callback = function()
          vim.lsp.buf.format { async = true }
        end,
      })
    end

    if client.server_capabilities.documentHighlightProvider then
      local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", {})
      vim.opt.updatetime = 1000
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf,
        group = group,
        callback = function()
          vim.lsp.buf.document_highlight()
        end,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved" }, {
        buffer = args.buf,
        group = group,
        callback = function()
          vim.lsp.buf.clear_references()
        end,
      })
    end
  end
})

vim.api.nvim_set_hl(0, 'LspReferenceRead', { bold = true, ctermbg = "red", bg = "LightYellow" })
vim.api.nvim_set_hl(0, 'LspReferenceText', { bold = true, ctermbg = "red", bg = "LightYellow" })
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bold = true, ctermbg = "red", bg = "LightYellow" })

-- null_ls.setup {
--   sources = {
--     -- null_ls.builtins.formatting.prettier.with({
--     --     extra_filetypes = { "toml", "graphql" },
--     -- }),
--     -- null_ls.builtins.diagnostics.actionlint,
--     null_ls.builtins.formatting.biome,
--     null_ls.builtins.diagnostics.shellcheck,
--     null_ls.builtins.diagnostics.statix,
--     -- null_ls.builtins.code_actions.gitsigns,
--     null_ls.builtins.code_actions.shellcheck,
--     null_ls.builtins.code_actions.statix,
--   },
-- }

nvim_lsp.bashls.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.biome.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.clangd.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.cssls.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.dockerls.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.eslint.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.gopls.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.html.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.jsonls.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.graphql.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.tailwindcss.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- nvim_lsp.pylsp.setup {
--   capabilities = capabilities,
--   flags = {
--     debounce_text_changes = 150,
--   },
--   settings = {
--     pylsp = {
--       plugins = {
--         flake8 = { enabled = false },
--         autopep8 = { enabled = false },
--         yapf = { enabled = false },
--       },
--     },
--   },
-- }

nvim_lsp.pyright.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    python = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = false,
        excludee = {'**/.direnv', '**/.tox'},
      },
    },
  },
}

nvim_lsp.nil_ls.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

vim.g.rustaceanvim = function()
  -- Update this path
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

nvim_lsp.terraformls.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.ts_ls.setup {
  on_attach = function(client, bufnr)
    -- Disable the tsserver formatter
    client.server_capabilities.documentFormattingProvider = false
  end,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.yamlls.setup {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  },
}

-- nvim_lsp.zls.setup {
--   capabilities = capabilities,
--   flags = {
--     debounce_text_changes = 150,
--   },
-- }
