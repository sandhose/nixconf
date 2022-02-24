-- LSP config, here we go!
local lsp_status = require'lsp-status'
lsp_status.register_progress()

local nvim_lsp = require'lspconfig'

local null_ls = require'null-ls'

lsp_status.config {
  diagnostics = false, -- Disable diagnostic since it's already handled by lualine
}

-- Advertise snippets support
local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua require"trouble".previous({skip_groups = true, jump = true})<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua require"trouble".next({skip_groups = true, jump = true})<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>Trouble loclist', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    vim.api.nvim_command("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
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
    null_ls.builtins.formatting.prettier.with({
        extra_filetypes = { "toml", "graphql" },
    }),
    null_ls.builtins.formatting.eslint_d.with({
        extra_filetypes = { "graphql" },
    }),
    null_ls.builtins.diagnostics.eslint_d.with({
        extra_filetypes = { "graphql" },
    }),
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.statix,
    null_ls.builtins.code_actions.eslint_d.with({
        extra_filetypes = { "graphql" },
    }),
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.gitrebase,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.code_actions.statix,
  },
  on_attach = on_attach,
}

nvim_lsp.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.clangd.setup {
  handlers = lsp_status.extensions.clangd.setup(),
  init_options = {
    clangdFileStatus = true
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- nvim_lsp.pylsp.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
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
  settings = {
    python = {
      analysis = {
        useLibraryCodeForTypes = false,
        excludee = {'**/.direnv', '**/.tox'},
      },
    },
  },
}

nvim_lsp.rnix.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require'rust-tools'.setup {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
        procMacro = {
          ignored = {
            ["async-trait"] = {"async_trait"},
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
}

nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    -- Disable the tsserver formatter
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

nvim_lsp.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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
