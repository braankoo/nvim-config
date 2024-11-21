require('lualine').setup({})


-- Postavite lualine i omogućite prikazivanje statusne linije u komandnom režimu
vim.cmd([[
    augroup LualineCommand
    autocmd!
    autocmd CmdlineEnter * set cmdheight=1
    autocmd CmdlineLeave * set cmdheight=0
    augroup END
    ]])

