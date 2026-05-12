local M = {}
local Menu = require('nui.menu')
local Input = require('nui.input')

local monorepos = {
  ca = { 'monorepo' },
  us = { 'monorepo' },
}

local border = {
  style = 'rounded',
  text = { top_align = 'center' },
}

local win_opts = {
  winhighlight = 'Normal:Normal,FloatBorder:DiagnosticInfo',
}

local function popup_size(items)
  local width = 30
  for _, item in ipairs(items) do
    if #item > width then width = #item end
  end
  return { width = width + 4, height = #items }
end

local function branch_input(region, repo)
  local input = Input({
    position = '50%',
    size = { width = 40 },
    border = vim.tbl_deep_extend('force', border, {
      text = { top = ' Branch [' .. region .. '/' .. repo .. '] ' },
    }),
    win_options = win_opts,
  }, {
    prompt = '> ',
    placeholder = 'Enter = bez override',
    on_submit = function(branch)
      local args = region:lower()
      if branch ~= '' then
        args = args .. ' ' .. branch
      end
      vim.cmd('FloatermNew bash ~/Buckhill/projects/scripts/deploy.sh ' .. args)
    end,
  })
  input:mount()
  input:map('i', '<Esc>', function() input:unmount() end)
end

local function monorepo_menu(region)
  local items = {}
  for _, name in ipairs(monorepos[region:lower()]) do
    table.insert(items, Menu.item(name))
  end

  local size = popup_size(monorepos[region:lower()])
  local menu = Menu({
    position = '50%',
    size = size,
    border = vim.tbl_deep_extend('force', border, {
      text = { top = ' Monorepo [' .. region .. '] ' },
    }),
    win_options = win_opts,
  }, {
    lines = items,
    on_submit = function(item)
      branch_input(region, item.text)
    end,
  })
  menu:mount()
end

local function region_menu()
  local regions = { 'CA', 'US' }
  local size = popup_size(regions)
  local menu = Menu({
    position = '50%',
    size = size,
    border = vim.tbl_deep_extend('force', border, {
      text = { top = ' Deploy — Regija ' },
    }),
    win_options = win_opts,
  }, {
    lines = { Menu.item('CA'), Menu.item('US') },
    on_submit = function(item)
      monorepo_menu(item.text)
    end,
  })
  menu:mount()
end

function M.run()
  region_menu()
end

vim.api.nvim_create_user_command('Deploy', M.run, { desc = 'Deploy na ITS' })

return M
