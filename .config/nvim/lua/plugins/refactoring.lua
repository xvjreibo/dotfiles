return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
      {
        "<leader>rn",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        desc = "Incremental rename across all files",
        mode = "n",
        noremap = true,
        expr = true,
      },
    },
    config = true,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>rf",
        function()
          require("refactoring").select_refactor({
            show_success_message = true,
          })
        end,
        desc = "Refactor",
        mode = "v",
        noremap = true,
        expr = false,
        silent = true,
      },
    },
    opts = {},
  },
}
