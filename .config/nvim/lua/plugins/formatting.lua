local util = require("conform.util")
local prettier_custom = vim.deepcopy(require("conform.formatters.prettier"))
util.add_formatter_args(prettier_custom, { "--single-attribute-per-line" })

return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    opts = function()
      local opts = {
        formatters_by_ft = {
          html = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          fish = { "fish_indent" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          lua = { "stylua" },
          python = { "isort", "black" },
        },
        formatters = {
          prettier = prettier_custom,
        },
      }
      return opts
    end,
  },
}
