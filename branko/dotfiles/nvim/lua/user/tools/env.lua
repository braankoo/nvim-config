local M = {}

-- Penji se uz stablo dok ne nađeš `.env`, zatim `:cd` tamo.
function M.cd_to_env_root()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].filetype == "NvimTree" then
    vim.notify("NvimTree buffer detected. Skipping directory change.", vim.log.levels.INFO)
    return
  end

  local path = vim.fn.expand("%:p:h")
  while path and path ~= "/" do
    if vim.fn.glob(path .. "/.env") ~= "" then
      vim.cmd("cd " .. vim.fn.fnameescape(path))
      vim.notify("Changed directory to: " .. path, vim.log.levels.INFO)
      return
    end
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then
      break
    end
    path = parent
  end
  vim.notify(".env not found in any parent directory", vim.log.levels.WARN)
end

return M
