vim.g.floaterm_wintype = 'float'         
vim.g.floaterm_height = 0.8              
vim.g.floaterm_width = 0.8               
vim.g.floaterm_position = 'center'       

vim.keymap.set('n','<F1>','<cmd>FloatermToggle<CR>')
vim.keymap.set('t','<F1>','<C-\\><C-n><cmd>FloatermToggle<CR>')

vim.api.nvim_set_hl(0, 'FloatermBorder', {
  fg = '#7aa2f7',
  bg = '#1a1b26',
  blend = 0,
})
vim.cmd([[
    highlight link Floaterm CursorLine
    highlight link FloatermBorder CursorLineBg
]])
