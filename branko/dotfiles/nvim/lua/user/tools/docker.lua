local fs = require("user.utils.fs")

local M = {}

local CONFIG_FILE = "docker.json"

function M.shell()
  local start_dir = fs.get_target_dir()
  local found = fs.find_file_upward(start_dir, CONFIG_FILE)
  if not found then
    vim.notify("No " .. CONFIG_FILE .. " found in parent directories.", vim.log.levels.WARN)
    return
  end

  local content = table.concat(vim.fn.readfile(found), "\n")
  local ok, json = pcall(vim.fn.json_decode, content)
  if not ok or type(json) ~= "table" then
    vim.notify("Failed to parse " .. found, vim.log.levels.ERROR)
    return
  end

  local cmd = string.format(
    "docker exec -it %s bash -c 'cd %s && bash'",
    json.container,
    json.path
  )
  vim.cmd("FloatermNew --wintype=float --autoclose=0 bash -c " .. vim.fn.shellescape(cmd))
end

return M
