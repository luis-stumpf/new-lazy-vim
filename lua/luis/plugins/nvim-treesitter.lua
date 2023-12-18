return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    config = function ()
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        ensure_installed = { "vimdoc", "javascript", "typescript", "lua" },
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end
}
