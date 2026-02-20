return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {
          "lua",
          "javascript",
          "typescript",
          "html",
          "css",
          "json",
          "yaml",
          "toml",
          "markdown",
          "markdown_inline",
          "c",
          "rust",
          "bash",
          "vim",
          "vimdoc",
          "query",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
