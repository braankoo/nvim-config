require('dashboard').setup({
    theme = 'doom',
    config = {
        header = {
            "  _   _      _ _         __        __         _     _ _",
            " | | | | ___| | | ___    \\ \\      / /__  _ __| | __| | |",
            " | |_| |/ _ \\ | |/ _ \\    \\ \\ /\\ / / _ \\| '__| |/ _` | |",
            " |  _  |  __/ | | (_) |    \\ V  V / (_) | |  | | (_| |_|",
            " |_| |_|\\___|_|_|\\___( )    \\_/\\_/ \\___/|_|  |_|\\__,_(_)",
            "                     |/                                ",
        },
        center = {
            {
                icon = '',
                icon_hl = 'group',
                desc = 'C2MS V2',
                desc_hl = 'group',
                key = 'c2',  -- Set the shortcut key to 'c2'
                key_hl = 'group',
                action = function()
                    vim.cmd('cd ~/Buckhill/InsurancePlatform/PDE/v1/sources/c2ms/monorepo.c2ms.localhost/v2.c2ms/')
                    vim.cmd('edit .')
                end,
            },
            {
                icon = '',
                icon_hl = 'group',
                desc = 'C2MS Framework',
                desc_hl = 'group',
                key = 'cf',  -- Set the shortcut key to 'c2'
                key_hl = 'group',
                action = function()
                    vim.cmd('cd ~/Buckhill/InsurancePlatform/PDE/v1/sources/c2ms/monorepo.c2ms.localhost/framework/')
                    vim.cmd('edit .')
                end,
            },
            {
                icon = '',
                icon_hl = 'group',
                desc = 'AuthStack',
                desc_hl = 'group',
                key = 'au',  -- Set the shortcut key to 'au'
                key_hl = 'group',
                key_format = ' [%s]', -- `%s` will be substituted with value of `key`
                action = function()
                    vim.cmd('cd ~/Buckhill/InsurancePlatform/PDE/v1/sources/authstack/dev.authstack.localhost')
                    vim.cmd('edit .')
                end,
            },
            {
                icon = '',
                icon_hl = 'group',
                desc = 'Claims',
                desc_hl = 'group',
                key = 'cl',  -- Set the shortcut key to 'cl'
                key_hl = 'group',
                key_format = ' [%s]', -- `%s` will be substituted with value of `key`
                action = function()
                    vim.cmd('cd ~/Buckhill/InsurancePlatform/PDE/v1/sources/claims/dev.claims.localhost/api')
                    vim.cmd('edit .')
                end,
            },
            {
                icon = '',
                icon_hl = 'group',
                desc = 'Broker Portal',
                desc_hl = 'group',
                key = 'bp',  -- Set the shortcut key to 'bp'
                key_hl = 'group',
                key_format = ' [%s]', -- `%s` will be substituted with value of `key`
                action = function()
                    vim.cmd('cd ~/Buckhill/InsurancePlatform/PDE/v1/sources/brokerportal/dev.brokerportal.localhost')
                    vim.cmd('edit .')
                end,
            },
            {
                icon = '',
                icon_hl = 'group',
                desc = 'C2MS monorepo',
                desc_hl = 'group',
                key = 'mr',  -- Set the shortcut key to 'c2'
                key_hl = 'group',
                action = function()
                    vim.cmd('cd ~/Buckhill/InsurancePlatform/PDE/v1/sources/c2ms/monorepo.c2ms.localhost/')
                    vim.cmd('edit .')
                end,
            },
            {
                icon = '',
                icon_hl = 'group',
                desc = 'Blocks',
                desc_hl = 'group',
                key = 'bl',  -- Set the shortcut key to 'c2'
                key_hl = 'group',
                action = function()
                    vim.cmd('cd ~/Buckhill/InsurancePlatform/PDE/v1/sources/blocks-portal/')
                    vim.cmd('edit .')
                end,
            },
            {
                icon = '',
                icon_hl = 'group',
                desc = 'Ad Machine',
                desc_hl = 'group',
                key = 'ama',  -- Set the shortcut key to 'c2'
                key_hl = 'group',
                action = function()
                    vim.cmd('cd ~/projects/nekretnine/api/')
                    vim.cmd('edit .')
                end,
            },
            {
                icon = '',
                icon_hl = 'group',
                desc = 'Ad Machine',
                desc_hl = 'group',
                key = 'amf',  -- Set the shortcut key to 'c2'
                key_hl = 'group',
                action = function()
                    vim.cmd('cd ~/projects/nekretnine/fe/')
                    vim.cmd('edit .')
                end,
            },

        },
        footer = {
            "Neovim powered by Lua",
            "Configured with ❤️ by YourName",
        },
    }
})

