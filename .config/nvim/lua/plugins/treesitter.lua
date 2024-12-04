return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "gitignore",
        "graphql",
        "http",
        "sql",
        "python",
        "vim",
        "lua",
      },
    },
  },
}
