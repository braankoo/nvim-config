require('mason').setup()
require('mason-lspconfig').setup({automatic_installation = true})


local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

--PHP

require('lspconfig').intelephense.setup({capabilities = capabilities })

require('lspconfig').volar.setup({
        filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
        init_options = {
        vue = {
          hybridMode = false,
        },
      },
    })


-- Tailwind
require('lspconfig').tailwindcss.setup({capabilities = capabilities })

-- JSON
require('lspconfig').jsonls.setup({
        capabilities = capabilities,
        settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
            },
        },
    })

-- GO
require('lspconfig').gopls.setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
    },
  },
})

local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
        require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
    },
})

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    
null_ls.setup({
  temp_dir = '/tmp',
  sources = {
    -- eslint (requires none-ls-extras.nvim)
    require("none-ls.diagnostics.eslint"),
    
    -- trail_space
    null_ls.builtins.diagnostics.trail_space.with({
      disabled_filetypes = { "NvimTree" },
    }),
    
    -- PHP pint
    null_ls.builtins.formatting.pint.with({
      condition = function(utils)
        return utils.root_has_file({ "vendor/bin/pint" })
      end,
    }),
    
    -- prettier
    null_ls.builtins.formatting.prettier.with({
      condition = function(utils)
        return utils.root_has_file({
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.yml",
          ".prettierrc.js",
          "prettier.config.js",
        })
      end,
    }),

    -- stylua
    null_ls.builtins.formatting.stylua,

    -- spell completion
    null_ls.builtins.completion.spell,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
        end,
      })
    end
  end,
})

    require('mason-null-ls').setup({ automatic_installation = true })

vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
vim.keymap.set('n', '<Leader>lr', ':LspRestart<CR>', { silent = true })
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'jgd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ timeout_ms = 5000 }) end, {})

vim.g.go_doc_popup_window = 1

vim.diagnostic.config({
        virtual_text = true,
        float = {
            source = true,
        },
    })
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
