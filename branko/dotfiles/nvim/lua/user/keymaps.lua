-- Space is my leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear search highlighting.
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Close all open buffers.
vim.keymap.set('n', '<leader>Q', ':bufdo bdelete<CR>')

-- Diagnostics.
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic' })

-- Allow gf to open non-existent files.
vim.keymap.set('', 'gf', ':edit <cfile><CR>')

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.

-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

-- Reselect pasted text
vim.keymap.set('n', 'p', 'p`[v`]')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>A;<Esc>')
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set('n', '<leader>x', ':!xdg-open %<cr><cr>')

-- Disable annoying command line thing.
vim.keymap.set('n', 'q:', ':q<CR>')

-- Resize with arrows.
vim.keymap.set('n', '<C-w>>', ':vertical resize +20<CR>',{ noremap = true, silent = true })
-- Smanji širinu prozora
vim.keymap.set('n', '<C-w><', ':vertical resize -20<CR>',{ noremap = true, silent = true })



vim.keymap.set('i', '<C-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<C-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<C-j>', ':move .+1<CR>==')
vim.keymap.set('n', '<C-k>', ':move .-2<CR>==')
vim.keymap.set('v', '<C-k>', ":move '<-2<CR>gv=gv")
vim.keymap.set('v', '<C-j>', ":move '>+1<CR>gv=gv")

-- Equalize window sizes
vim.keymap.set('n', '<C-w>=', '<C-w>=')
--Lazygit
--Lazydocker
vim.keymap.set("n", "<leader>ld", "<cmd>LazyDocker<CR>", { desc = "Toggle LazyDocker", noremap = true, silent = true })

--Format
vim.keymap.set("n","<leader>fmt","<cmd>Format<CR>", { desc = "Format"})
--Terminal
vim.keymap.set("n","<leader>ft","<cmd>FloatermToggle<cmd>", { desc = "Toggle Terminal" })


vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
vim.g.copilot_no_tab_map = true

vim.keymap.set('n', '<leader>cct', ':CopilotChatToggle<CR>', { desc = 'Toggle Copilot Chat' })
vim.keymap.set('n', '<leader>ccc', ':CopilotChatCommit<CR>', { desc = 'Toggle Copilot Chat Commit' })
vim.keymap.set('v', '<leader>cce', ':CopilotChatExplain<CR>', { desc = 'Toggle Copilot Chat Explain' })

--Copy filename
vim.api.nvim_create_user_command('CopyFilename', function()
    vim.fn.setreg('+', vim.fn.expand("%"))
end, {})
vim.keymap.set('n', '<leader>cfn', ':CopyFilename<CR>')


vim.api.nvim_set_keymap('v', '<leader>ccyp', '"+y :CopilotChat<CR>i<C-R>+<CR>', { noremap = true, silent = true })


vim.keymap.set('n', '<leader>ma', ':lua require("harpoon.mark").add_file()<CR>', { desc = 'Add file to harpoon' })
vim.keymap.set('n', '<leader>mt', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { desc = 'Toggle harpoon menu' })




vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
-- vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
-- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
