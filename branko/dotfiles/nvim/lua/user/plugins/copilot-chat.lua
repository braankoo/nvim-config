return function(use)
  use({
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    requires = {
      { "zbirenbaum/copilot.lua" },  -- you can also use { "github/copilot.vim" }
      { "nvim-lua/plenary.nvim" },   -- needed for curl, log wrapper
    },
    run = "make tiktoken",  -- Only on MacOS or Linux
    config = function()
      require('CopilotChat').setup({
        debug = false,  -- enable debugging
        -- add your other configuration here
      })
    end,
  })
end
