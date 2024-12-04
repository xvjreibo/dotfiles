return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup({
        ensure_installed = {
          "html",
          "cssls",
          "tailwindcss",
          "vtsls",
          "emmet_ls",
          "graphql",
          "prismals",
          "pyright",
          "lua_ls",
        },
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "prettier",
          "pylint",
          "isort", -- python formatter
          "black", -- python formatter
          "shellcheck",
          "shfmt",
          "stylua",
        },
      })
    end,
  },
}
