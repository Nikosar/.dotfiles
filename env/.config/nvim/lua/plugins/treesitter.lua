return {
  {"nvim-treesitter/nvim-treesitter", build=":TSUpdate",
  config = function() 
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
        ensure_installed = {"lua", "javascript", "typescript", "java", "tsx"},
        highlight = { enable = true },
        indent = { enable = true }, 
      })
  end
  }
}
