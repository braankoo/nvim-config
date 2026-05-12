-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Colorscheme — eager, loaded first.
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme tokyonight-moon")

            local normal_float_bg = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false }).bg
            local cursor_line_bg = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false }).bg

            vim.api.nvim_set_hl(0, "FloatBorder", { fg = normal_float_bg, bg = normal_float_bg })
            vim.api.nvim_set_hl(0, "CursorLineBg", { fg = cursor_line_bg, bg = cursor_line_bg })
            vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#30323E" })
            vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#2F313C" })
        end,
    },

    -- Editing essentials.
    { "tpope/vim-commentary", event = "VeryLazy" },
    { "tpope/vim-surround",   event = "VeryLazy" },
    { "tpope/vim-unimpaired", event = "VeryLazy" },
    { "tpope/vim-repeat",     event = "VeryLazy" },
    { "tpope/vim-sleuth",     event = "BufReadPost" },
    {
        "tpope/vim-eunuch",
        cmd = { "Rename", "Move", "Delete", "Mkdir", "SudoEdit", "SudoWrite", "Wall" },
    },

    -- Navigation.
    { "christoomey/vim-tmux-navigator" },
    { "farmergreg/vim-lastplace",        event = "BufReadPre" },
    {
        "nelstrom/vim-visual-star-search",
        keys = { { "*", mode = "v" }, { "#", mode = "v" } },
    },
    { "jessarcher/vim-heritage", event = "BufNewFile" },

    -- Text objects.
    {
        "whatyouhide/vim-textobj-xmlattr",
        dependencies = { "kana/vim-textobj-user" },
        ft = { "html", "xml", "vue", "javascriptreact", "typescriptreact" },
    },

    -- Project root.
    {
        "airblade/vim-rooter",
        lazy = false,
        init = function()
            vim.g.rooter_manual_only = 1
        end,
        config = function()
            vim.cmd("Rooter")
        end,
    },

    -- UX.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        config = function()
            require("neoscroll").setup()
        end,
    },
    {
        "sickill/vim-pasta",
        event = "VeryLazy",
        init = function()
            vim.g.pasta_disabled_filetypes = { "fugitive" }
        end,
    },

    -- Buffer management.
    {
        "famiu/bufdelete.nvim",
        cmd = "Bdelete",
        keys = { { "<Leader>q", ":Bdelete<CR>" } },
    },

    -- Splitjoin.
    {
        "AndrewRadev/splitjoin.vim",
        keys = { "gJ", "gS" },
        init = function()
            vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
            vim.g.splitjoin_trailing_comma = 1
            vim.g.splitjoin_php_method_chain_full = 1
        end,
    },

    -- Telescope.
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = { "<leader>f", "<leader>F", "<leader>b", "<leader>g", "<leader>h", "<leader>s" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            require("user/plugins/telescope")
        end,
    },

    -- File explorer.
    {
        "kyazdani42/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeFindFileToggle" },
        keys = { { "<Leader>n", ":NvimTreeFindFileToggle<CR>", desc = "Toggle NvimTree" } },
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("user/plugins/nvim-tree")
        end,
    },

    -- Statusline / bufferline / indent guides.
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("user/plugins/lualine")
        end,
    },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        dependencies = { "kyazdani42/nvim-web-devicons", "folke/tokyonight.nvim" },
        config = function()
            require("user/plugins/bufferline")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
            require("user/plugins/indent-blankline")
        end,
    },

    -- Git.
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        config = function()
            require("user/plugins/gitsigns")
        end,
    },
    {
        "tpope/vim-fugitive",
        cmd = {
            "G", "Git", "Gdiff", "Gdiffsplit", "Gvdiffsplit",
            "Gread", "Gwrite", "Ggrep", "Glgrep",
            "GMove", "GDelete", "GBrowse", "GRemove", "GRename",
        },
    },

    -- Docker.
    {
        "crnvl96/lazydocker.nvim",
        cmd = "LazyDocker",
        keys = "<leader>ld",
        dependencies = { "MunifTanjim/nui.nvim" },
        config = function()
            require("lazydocker").setup()
        end,
    },

    -- Floating terminal.
    {
        "voldikss/vim-floaterm",
        cmd = { "FloatermNew", "FloatermToggle", "FloatermShow", "FloatermSend" },
        keys = {
            { "<leader>ft", "<cmd>FloatermToggle<CR>",                desc = "Toggle floaterm" },
            { "<F1>",       "<cmd>FloatermToggle<CR>",                desc = "Toggle floaterm" },
            { "<F1>",       "<C-\\><C-n><cmd>FloatermToggle<CR>",     desc = "Toggle floaterm", mode = "t" },
        },
        config = function()
            require("user/plugins/floaterm")
        end,
    },

    -- Treesitter (pinned to `master` — `main` branch is the new minimal rewrite
    -- which drops `nvim-treesitter.configs` and most of the modules we use).
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
        },
        config = function()
            require("user/plugins/treesitter")
        end,
    },

    -- LSP.
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "b0o/schemastore.nvim",
            "nvimtools/none-ls.nvim",
            "jay-babu/mason-null-ls.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            require("user/plugins/lspconfig")
        end,
    },

    -- Completion.
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
        },
        config = function()
            require("user/plugins/cmp")
        end,
    },

    -- PHP.
    {
        "phpactor/phpactor",
        ft = "php",
        build = "composer install --no-dev --optimize-autoload",
        keys = {
            { "<Leader>pm", ":PhpactorContextMenu<CR>" },
            { "<Leader>pn", ":PhpactorClassNew<CR>" },
        },
    },

    -- Projectionist.
    {
        "tpope/vim-projectionist",
        event = "VeryLazy",
        dependencies = { "tpope/vim-dispatch" },
        cmd = { "A", "AS", "AV", "AT", "AD", "AR", "E", "Cd", "Lcd" },
        config = function()
            require("user/plugins/projectionist")
        end,
    },

    -- Testing.
    {
        "vim-test/vim-test",
        cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
        keys = {
            { "<Leader>tn", ":TestNearest<CR>", desc = "Test nearest" },
            { "<Leader>tf", ":TestFile<CR>",    desc = "Test file" },
            { "<Leader>ts", ":TestSuite<CR>",   desc = "Test suite" },
            { "<Leader>tl", ":TestLast<CR>",    desc = "Test last" },
            { "<Leader>tv", ":TestVisit<CR>",   desc = "Test visit" },
        },
        config = function()
            require("user/plugins/vim-test")
        end,
    },

    -- DB.
    {
        "tpope/vim-dadbod",
        cmd = {
            "DB", "DBUI", "DBUIToggle", "DBUIAddConnection",
            "DBUIFindBuffer", "DBUILastQueryInfo", "DBUIRenameBuffer",
        },
        dependencies = {
            "kristijanhusak/vim-dadbod-ui",
            {
                "kristijanhusak/vim-dadbod-completion",
                config = function()
                    require("user/config/dadbod").setup()
                end,
            },
        },
    },

    -- Multi cursor.
    { "mg979/vim-visual-multi", branch = "master", keys = "<C-n>" },

    -- Which-key.
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({ global = false })
        end,
    },

    -- Harpoon v2.
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = { "<leader>ma", "<leader>mt" },
        config = function()
            require("harpoon"):setup()
        end,
    },

    -- DAP.
    {
        "mfussenegger/nvim-dap",
        keys = { "<F5>", "<F10>", "<F11>", "<F12>", "<leader>dh", "<leader>dp", "<leader>df", "<leader>ds" },
        config = function()
            require("user.plugins.dap")
        end,
    },

    -- nui (eager: deploy.lua does top-level require of nui.menu/nui.input).
    { "MunifTanjim/nui.nvim", lazy = false },
})
