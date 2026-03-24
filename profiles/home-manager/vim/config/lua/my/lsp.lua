-- LSP config, here we go!
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

-- Apply capabilities to all LSP servers
vim.lsp.config('*', {
  capabilities = capabilities,
})

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

vim.lsp.config('pyright', {
  settings = {
    python = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = false,
        excludee = {'**/.direnv', '**/.tox'},
      },
    },
  },
})

vim.lsp.config('ts_ls', {
  on_attach = function(client, bufnr)
    -- Disable the tsserver formatter
    client.server_capabilities.documentFormattingProvider = false
  end,
})

vim.lsp.config('yamlls', {
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
})

vim.lsp.enable({
  'bashls',
  'biome',
  'clangd',
  'cssls',
  'dockerls',
  'eslint',
  'gopls',
  'graphql',
  'html',
  'jsonls',
  'nil_ls',
  'pyright',
  'tailwindcss',
  'terraformls',
  'ts_ls',
  'yamlls',
})
