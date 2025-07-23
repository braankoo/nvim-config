require('user.plugins')
require('user.options')
require('user.keymaps')

function OpenLazygitInCurrentDir()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local buf_ft = vim.api.nvim_buf_get_option(current_buf, 'filetype')

  if buf_ft == 'NvimTree' then
    local api = require('nvim-tree.api')
    local node = api.tree.get_node_under_cursor()
    local path = node.absolute_path
    if vim.fn.isdirectory(path) == 1 then
      vim.cmd('cd ' .. path)
    else
      vim.cmd('cd ' .. vim.fn.fnamemodify(path, ':h'))
    end
  else
    local current_dir = vim.fn.expand('%:p:h')
    vim.cmd('cd ' .. current_dir)
  end
 local float = require('plenary.window.float').percentage_range_window(0.9, 0.9)
  vim.fn.termopen('lazygit', { cwd = vim.fn.getcwd() })
  vim.cmd('startinsert')

end

vim.api.nvim_set_keymap('n', '<leader>lg', ':lua OpenLazygitInCurrentDir()<CR>', { noremap = true, silent = true })
vim.o.timeoutlen = 100



function OpenMCInCurrentDir()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local buf_ft = vim.api.nvim_buf_get_option(current_buf, 'filetype')

  if buf_ft == 'NvimTree' then
    local api = require('nvim-tree.api')
    local node = api.tree.get_node_under_cursor()
    local path = node.absolute_path
    if vim.fn.isdirectory(path) == 1 then
      vim.cmd('cd ' .. path)
    else
      vim.cmd('cd ' .. vim.fn.fnamemodify(path, ':h'))
    end
  else
    local current_dir = vim.fn.expand('%:p:h')
    vim.cmd('cd ' .. current_dir)
  end
 local float = require('plenary.window.float').percentage_range_window(0.9, 0.9)
  vim.fn.termopen('mc', { cwd = vim.fn.getcwd() })
  vim.cmd('startinsert')

end

function changePWDtoFolderContainingENV()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local buf_ft = vim.api.nvim_buf_get_option(current_buf, 'filetype')

  if buf_ft == 'NvimTree' then
    print("NvimTree buffer detected. Skipping directory change.")
  else
    local path = vim.fn.expand('%:p:h')
    while path ~= '/' do
      if vim.fn.glob(path .. '/.env') ~= '' then
        vim.cmd('cd ' .. path)
        print('Changed directory to: ' .. path)
        return
      end
      path = vim.fn.fnamemodify(path, ':h')
    end
    print('.env not found in any parent directory')
  end
end
vim.api.nvim_set_keymap('n','<leader>gtr', ':lua changePWDtoFolderContainingENV()<CR>', { noremap = true, silent = true })
vim.opt.termguicolors = true

function runBashInDockerForCurrentProject()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local buf_ft = vim.api.nvim_buf_get_option(current_buf, 'filetype')
  local path
  local config_file = "docker.json"
  if buf_ft == 'NvimTree' then
    local api = require('nvim-tree.api')
    local node = api.tree.get_node_under_cursor()
    path = node.absolute_path
  else
    path = vim.fn.expand('%:p:h')
  end 
  local found_file = find_file_upward(path, config_file)
  if found_file then
    local content = vim.fn.readfile(found_file)
    local json_str = table.concat(content, '\n')
    local json = vim.fn.json_decode(json_str)
    local container = json.container
    local path = json.path
    local docker_command = "docker exec -it " .. container .. " bash -c 'cd " .. path .. " && bash'"
    vim.cmd("FloatermNew --wintype=float --autoclose=0 bash -c " .. vim.fn.shellescape(docker_command))
  else
    print("No " .. config_file .. " found in parent directories.")
  end
end
vim.api.nvim_create_user_command("DockerShell", runBashInDockerForCurrentProject, {})
vim.api.nvim_set_keymap('n', '<leader>ds', ':DockerShell<CR>', { noremap = true, silent = true })

function find_file_upward(start_dir, filename)
    local path = start_dir
    local home = vim.fn.expand('~')
    while path and path ~= home do
      local candidate = path .. '/' .. filename
      if vim.fn.filereadable(candidate) == 1 then
        return candidate
      end
      path = vim.fn.fnamemodify(path, ':h')
    end
  return nill
end




