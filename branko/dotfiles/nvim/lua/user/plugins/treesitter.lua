require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        highlight = {
            enable = true
        },
        indent = {
            enable = true,
        },
        additional_vim_regex_highlighting = true,
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['if'] = '@function.inner',
                    ['af'] = '@function.outer',
                    ['ia'] = '@parameter.inner',
                    ['aa'] = '@parameter.outer',
                },
            },
        },
    })
vim.g.skip_ts_context_commentstring_module = true
