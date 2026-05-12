local M = {}

-- Vrati ciljni direktorijum: ako je aktivni buffer NvimTree, koristi node
-- pod kursorom; inače, direktorijum trenutnog fajla.
function M.get_target_dir()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype

  if ft == "NvimTree" then
    local node = require("nvim-tree.api").tree.get_node_under_cursor()
    local path = node.absolute_path
    if vim.fn.isdirectory(path) == 1 then
      return path
    end
    return vim.fn.fnamemodify(path, ":h")
  end

  return vim.fn.expand("%:p:h")
end

-- Penji se uz stablo direktorijuma tražeći `filename`. Vrati apsolutnu
-- putanju ako nađe, inače nil. Staje na home direktorijumu.
function M.find_file_upward(start_dir, filename)
  local path = start_dir
  local home = vim.fn.expand("~")
  while path and path ~= home and path ~= "/" do
    local candidate = path .. "/" .. filename
    if vim.fn.filereadable(candidate) == 1 then
      return candidate
    end
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then
      break
    end
    path = parent
  end
  return nil
end

return M
