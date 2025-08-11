return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "cpp",
        "make",
        "lua",
        "vim",
        "vimdoc",
        "python",
        "bash",
        "toml",
        "yaml",
        "json",
        "go",
        "tmux",
        "tsx",
        "typescript",
        "javascript",
        "gitignore",
        "jsdoc",
        "zig",
        "markdown",
        "markdown_inline"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = false }
    })
  end
}
