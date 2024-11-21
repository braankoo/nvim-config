vim.g.floaterm_height = 0.2
vim.g.floaterm_wintype = 'split'
vim.keymap.set('n','<F1>','<cmd>FloatermToggle<CR>')
vim.keymap.set('t','<F1>','<C-\\><C-n><cmd>FloatermToggle<CR>')
vim.cmd([[
    highlight link Floaterm CursorLine
    highlight link FloatermBorder CursorLineBg
    ]])
