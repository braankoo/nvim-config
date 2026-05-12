local M = {}

local M_W, URI_W = 12, 48

local function truncate(str, len)
  if #str > len then return str:sub(1, len - 1) .. '…' end
  return str
end

local function format_table(rows)
  if #rows == 0 then return { 'No results found.' } end
  local lines = {}
  local sep = string.rep('─', M_W + 1) .. '┼' .. string.rep('─', URI_W + 2) .. '┼' .. string.rep('─', 40)
  table.insert(lines, string.format('%-' .. M_W .. 's │ %-' .. URI_W .. 's │ %s', 'METHOD', 'URI', 'CONTROLLER'))
  table.insert(lines, sep)
  for _, r in ipairs(rows) do
    table.insert(lines, string.format('%-' .. M_W .. 's │ %-' .. URI_W .. 's │ %s',
      truncate(r.method, M_W),
      truncate(r.uri, URI_W),
      r.controller
    ))
  end
  return lines
end

local function find_docker_json()
  local start_dir
  if vim.bo.filetype == 'NvimTree' then
    local node = require('nvim-tree.api').tree.get_node_under_cursor()
    if node then
      start_dir = node.type == 'directory' and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ':h')
    else
      start_dir = vim.fn.getcwd()
    end
  else
    start_dir = vim.fn.expand('%:p:h')
  end
  local dir = start_dir
  while dir ~= '/' do
    local path = dir .. '/docker.json'
    local f = io.open(path, 'r')
    if f then return f end
    dir = vim.fn.fnamemodify(dir, ':h')
  end
  return nil
end

function M.open()
  local Input = require('nui.input')
  local Popup = require('nui.popup')

  local input = Input({
    position = '50%',
    size = { width = 40 },
    border = {
      style = 'rounded',
      text = { top = ' Grep Laravel Routes ', top_align = 'center' },
    },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:DiagnosticInfo',
    },
  }, {
    prompt = '> ',
    on_submit = function(value)
      local f = find_docker_json()
      if not f then
        vim.notify('docker.json not found', vim.log.levels.ERROR)
        return
      end
      local config = vim.fn.json_decode(f:read('*a'))
      f:close()

      local popup = Popup({
        position = '50%',
        size = { width = '80%', height = '60%' },
        border = {
          style = 'rounded',
          text = { top = ' Routes: ' .. value .. ' ', top_align = 'center' },
        },
        win_options = {
          winhighlight = 'Normal:Normal,FloatBorder:DiagnosticInfo',
        },
        buf_options = { modifiable = true },
        enter = true,
      })
      popup:mount()
      vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, { 'Loading...' })
      vim.keymap.set('n', 'q', function() popup:unmount() end, { buffer = popup.bufnr })
      vim.keymap.set('n', '<Esc>', function() popup:unmount() end, { buffer = popup.bufnr })

      local function show_results(lines)
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(popup.bufnr) then
            vim.api.nvim_buf_set_option(popup.bufnr, 'modifiable', true)
            vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
            vim.api.nvim_buf_set_option(popup.bufnr, 'modifiable', false)
          end
        end)
      end

      -- Laravel 4.2 fallback
      local function run_routes_fallback()
        local raw = {}
        vim.fn.jobstart({
          'docker', 'exec', config.container,
          'sh', '-c', string.format('cd %s && php artisan routes', config.path)
        }, {
          stdout_buffered = true,
          on_stdout = function(_, data) if data then vim.list_extend(raw, data) end end,
          on_exit = function()
            vim.schedule(function()
              local rows = {}
              for _, line in ipairs(raw) do
                if line:find('|') then
                  local cols = {}
                  for col in line:gmatch('|([^|]+)') do
                    table.insert(cols, vim.trim(col))
                  end
                  if #cols >= 4 and not cols[2]:find('^%-+$') and cols[2] ~= 'URI' then
                    local method, uri = cols[2]:match('^(%u+)%s+(.+)$')
                    if method and uri then
                      local filter_lower = value:lower()
                      if uri:lower():find(filter_lower, 1, true) or cols[4]:lower():find(filter_lower, 1, true) then
                        local controller = cols[4]
                        table.insert(rows, { method = method, uri = uri, controller = controller })
                      end
                    end
                  end
                end
              end
              show_results(format_table(rows))
            end)
          end,
        })
      end

      -- Laravel 5+ via JSON
      local json_output = {}
      vim.fn.jobstart({
        'docker', 'exec', config.container,
        'sh', '-c', string.format('cd %s && php artisan route:list --json --no-ansi 2>/dev/null', config.path)
      }, {
        stdout_buffered = true,
        on_stdout = function(_, data) if data then vim.list_extend(json_output, data) end end,
        on_exit = function(_, exit_code)
          vim.schedule(function()
            if exit_code ~= 0 then
              run_routes_fallback()
              return
            end
            local ok, routes = pcall(vim.fn.json_decode, table.concat(json_output, ''))
            if not ok or type(routes) ~= 'table' then
              run_routes_fallback()
              return
            end
            local rows = {}
            local filter_lower = value:lower()
            for _, r in ipairs(routes) do
              local uri = r.uri or ''
              local method = r.method or ''
              local action = r.action or ''
              if uri:lower():find(filter_lower, 1, true) or action:lower():find(filter_lower, 1, true) then
                local controller = action
                table.insert(rows, { method = method, uri = uri, controller = controller })
              end
            end
            show_results(format_table(rows))
          end)
        end,
      })
    end,
  })
  input:mount()
end

return M
