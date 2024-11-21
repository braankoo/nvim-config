local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()


require('packer').reset()
require('packer').init({
        compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_complied.lua',
        display = {
            open_fn = function()
                return require('packer.util').float({border ='solid'})
            end,
        }
    })


local use = require('packer').use

use 'wbthomason/packer.nvim'

use({
        'jessarcher/onedark.nvim',
        config = function()
            vim.cmd('colorscheme onedark')

            vim.api.nvim_set_hl(0,'FloatBorder',{

                    fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
                    bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,

                })
            vim.api.nvim_set_hl(0,'CursorLineBg',{

                    fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
                    bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,

                })
            vim.api.nvim_set_hl(0,'NvimTreeIndentMarker', { fg = '#30323E'})
            vim.api.nvim_set_hl(0,'IndentBlanklineChar', { fg = '#2F313C'})

        end,
    })


-- Commenting support
use('tpope/vim-commentary')

-- Add, change and delete surrounding text
use('tpope/vim-surround')

-- Useful commands like :Rename and SudoWrite
use('tpope/vim-eunuch')

-- pairs of hand bracket mappings
use('tpope/vim-unimpaired')

-- indention
use('tpope/vim-sleuth')


use('tpope/vim-repeat')
    -- add more languages

    use('sheerun/vim-polyglot')

    --navigate between tmux and vim
    use('christoomey/vim-tmux-navigator')


    use('farmergreg/vim-lastplace')

    use('nelstorm/vim-visual-star-search')

    use('jessarcher/vim-heritage')


    use({
            'whatyouhide/vim-textobj-xmlattr',
            requires = 'kana/vim-textobj-user',
        })


    use({
            'airblade/vim-rooter',
            setup = function()
                vim.g.rooter_manual_only = 1
            end,
            config = function()
                vim.cmd('Rooter')
            end,
        })

    use({
            'windwp/nvim-autopairs',
            config = function()
                require('nvim-autopairs').setup()
            end,
        })


    use({
            'karb94/neoscroll.nvim',
            config = function()
                require('neoscroll').setup()
            end,
        })

    use({
            'famiu/bufdelete.nvim',
            config = function()
                vim.keymap.set('n','<Leader>q',':Bdelete<CR>')
            end,
        })

    use({
            'AndrewRadev/splitjoin.vim',
            config = function()
                vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
                vim.g.splitjoin_trailing_comma = 1
                vim.g.splitjoin_php_method_chain_full = 1
            end,
        })
    use({
            'sickill/vim-pasta',
            config = function()
                vim.g.pasta_disabled_filetypes = {'fugitive'}
            end,
        })

    use({
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
                'kyazdani42/nvim-web-devicons',
                'nvim-telescope/telescope-live-grep-args.nvim',
                {
                    'nvim-telescope/telescope-fzf-native.nvim', run ='make'
                },
            },
            config = function()
                require('user/plugins/telescope')
            end,
        })

    use({
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require('user/plugins/nvim-tree')
            end,
        })

    use({
            'nvim-lualine/lualine.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require('user/plugins/lualine')
            end,
        })
    use({
            'akinsho/bufferline.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            after = 'onedark.nvim',
            config = function()
                require('user/plugins/bufferline')
            end,
        })

    use({
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('user/plugins/indent-blankline')
            end,
        })
    use({
            'glepnir/dashboard-nvim',
            event = 'VimEnter',
            config = function()
                require('user/plugins/dashboard')
            end,
            requires = {'nvim-tree/nvim-web-devicons'}

        })
    use({
            'lewis6991/gitsigns.nvim',
            config = function()
                require('user/plugins/gitsigns')
            end,
        })
    use({
            'tpope/vim-fugitive',
            required = 'tpope/vim-rhubarb'
        })
    use({
            "kdheepak/lazygit.nvim",
            -- optional for floating window border decoration
            requires = {
                "nvim-lua/plenary.nvim",
            },
        })
    use({
            "crnvl96/lazydocker.nvim",
            config = function()
                require("lazydocker").setup()
            end,
            requires = {
                "MunifTanjim/nui.nvim",
            }
        })
    use({
            'voldikss/vim-floaterm',
            config = function()
                require('user/plugins/floaterm')
            end
        })

    use({
            'nvim-treesitter/nvim-treesitter',
            run = function()
                require('nvim-treesitter.install').update({with_sync = true})
            end,
            requires = {
                'JoosepAlviste/nvim-ts-context-commentstring',
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            config = function()
                require('user/plugins/treesitter')
            end,
        })
    use({
            'neovim/nvim-lspconfig',
            requires = {
                'williamboman/mason.nvim',
                'williamboman/mason-lspconfig.nvim',
                'b0o/schemastore.nvim',
                'jose-elias-alvarez/null-ls.nvim',
                'jayp0521/mason-null-ls.nvim'
            },
            config = function()
                require('user/plugins/lspconfig')
            end,

        })
    use({
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lsp-signature-help',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
                'onsails/lspkind-nvim'
            },
            config = function()
                require('user/plugins/cmp')
            end,
        })
    use({
            'phpactor/phpactor',
            ft = 'php',
            run = 'composer install -no-dev --optimize-autoload',
            config = function()
                vim.keymap.set('n','<Leader>pm', ':PhpactorContextMenu<CR>')
                vim.keymap.set('n','<Leader>pn',':PhpactorClassNew<CR>')
            end,
        })

    use({
            'tpope/vim-projectionist',
            requires = 'tpope/vim-dispatch',
            config = function()
                require('user/plugins/projectionist')
            end,
        })

    use({
            'vim-test/vim-test',
            config = function()
                require('user/plugins/vim-test')
            end,
        })
    use({
            'tpope/vim-dadbod'
        })
    use({
            'kristijanhusak/vim-dadbod-ui'
        })
    use({
            'kristijanhusak/vim-dadbod-completion',
            config = function()
                require('user/config/dadbod').setup()
            end,
        })
use({
    'github/copilot.vim'
})
use({
    'tpope/vim-surround'
})
use({
    'mg979/vim-visual-multi', branch = 'master'
})

require('user.plugins.copilot-chat')(use)


    if packer_bootstrap then
        require('packer').sync()
    end

    vim.cmd([[
        augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
    ]])
