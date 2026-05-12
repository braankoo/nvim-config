vim.api.nvim_create_user_command("DockerShell", function()
  require("user.tools.docker").shell()
end, {})

-- Registruje :Deploy komandu (deploy.lua koristi nui, koji se učitava eagerly).
require("user.plugins.deploy")
