require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'lua', 'luadoc', 'vim', 'vimdoc',
        'php', 'phpdoc',
        'javascript', 'typescript', 'tsx',
        'vue',
        'html', 'css', 'scss',
        'json', 'jsonc', 'yaml', 'toml',
        'markdown', 'markdown_inline',
        'bash',
        'dockerfile',
        'sql',
        'regex',
        'go', 'gomod',
        'python',
        'diff', 'gitignore', 'gitcommit', 'git_rebase',
    },
    auto_install = false,
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    additional_vim_regex_highlighting = false,
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
