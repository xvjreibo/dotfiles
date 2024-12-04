return {
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },
  {
    "telescope.nvim",
    priority = 1000,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      {
        "<Leader><space>",
        function()
          require("telescope.builtin").find_files({
            no_ignore = false,
            hidden = true,
          })
        end,
        desc = "Lists files in your current working directory",
      },
      {
        ";f",
        function()
          require("telescope.builtin").treesitter()
        end,
        desc = "Lists Function names, variables, from Treesitter in the current file",
      },
      -- {
      --   ";d",
      --   function()
      --     local telescope = require("telescope")
      --
      --     local function telescope_buffer_dir()
      --       return vim.fn.expand("%:p:h")
      --     end
      --
      --     telescope.extensions.file_browser.file_browser({
      --       path = "%:p:h",
      --       cwd = telescope_buffer_dir(),
      --       respect_gitignore = false,
      --       hidden = true,
      --       grouped = true,
      --       previewer = false,
      --       initial_mode = "normal",
      --       layout_config = { height = 40 },
      --     })
      --   end,
      --   desc = "Open File Browser with the path of the current buffer",
      -- },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {
            ["ts"] = actions.select_tab,
            ["ws"] = actions.select_vertical,
          },
        },
      })
      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      -- opts.extensions = {
      --   file_browser = {
      --     theme = "dropdown",
      --     hijack_netrw = true,
      --     mappings = {
      --       ["n"] = {
      --         ["a"] = fb_actions.create,
      --       },
      --     },
      --   },
      -- }
      telescope.setup(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<Leader>gs", ":Gitsigns preview_hunk<CR>", { desc = "Git sign" })
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    opts = {
      provider_selector = function()
        return { "lsp", "indent" }
      end,
    },
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      vim.api.nvim_set_keymap("n", ".", "za", { noremap = false })
    end,
  },
}
