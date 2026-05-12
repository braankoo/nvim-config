local fs = require("user.utils.fs")

local M = {}

function M.open()
  local dir = fs.get_target_dir()
  vim.cmd("cd " .. vim.fn.fnameescape(dir))
  require("plenary.window.float").percentage_range_window(0.9, 0.9)
  vim.fn.termopen("lazygit", { cwd = vim.fn.getcwd() })
  vim.cmd("startinsert")
end

return M
