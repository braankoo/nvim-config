vim.loader.enable()

-- Leader mora biti definisan PRE Lazy bootstrap-a, jer Lazy ekspanduje
-- <Leader> u trenutnu vrednost mapleader-a pri registraciji keys polja.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("user.plugins")
require("user.options")
require("user.keymaps")
require("user.tools")
