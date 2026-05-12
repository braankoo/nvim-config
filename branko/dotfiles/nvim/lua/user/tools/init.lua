vim.api.nvim_create_user_command("DockerShell", function()
  require("user.tools.docker").shell()
end, {})
