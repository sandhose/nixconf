-- LSP config, here we go!
local lsp_status = require'lsp-status'
lsp_status.register_progress()

local nvim_lsp = require'lspconfig'

require'fidget'.setup {}

local null_ls = require'null-ls'

lsp_status.config {
  diagnostics = false, -- Disable diagnostic since it's already handled by lualine
}

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

-- Keybindings
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  lsp_status.on_attach(client, bufnr)

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '', {
    noremap = true,
    silent = true,
    desc = 'Jump to definition',
    callback = function() 
      vim.lsp.buf.definition()
    end,
  })

  buf_set_keymap('n', 'K', '', {
    noremap = true,
    silent = true,
    desc = 'Show hover',
    callback = function() 
      vim.lsp.buf.hover()
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

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

null_ls.setup {
  sources = {
    -- null_ls.builtins.formatting.prettier.with({
    --     extra_filetypes = { "toml", "graphql" },
    -- }),
    null_ls.builtins.formatting.eslint_d.with({
        extra_filetypes = { "graphql" },
    }),
    null_ls.builtins.diagnostics.eslint_d.with({
        extra_filetypes = { "graphql" },
    }),
    -- null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.statix,
    null_ls.builtins.code_actions.eslint_d.with({
        extra_filetypes = { "graphql" },
    }),
    -- null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.code_actions.statix,
  },
  on_attach = on_attach,
}

nvim_lsp.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.clangd.setup {
  handlers = lsp_status.extensions.clangd.setup(),
  init_options = {
    clangdFileStatus = true
  },
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.graphql.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- nvim_lsp.pylsp.setup {
--   on_attach = on_attach,
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
  on_attach = on_attach,
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

nvim_lsp.rnix.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

require'rust-tools'.setup {
  dap = {
    adapter = require'dap'.adapters.codelldb
  },
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      ["rust-analyzer"] = {
        -- checkOnSave = {
        --   command = "clippy",
        -- },
        rustfmt = {
          extraArgs = { "+nightly-2023-11-18", },
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
}

nvim_lsp.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    -- Disable the tsserver formatter
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.yamlls.setup {
  on_attach = on_attach,
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
