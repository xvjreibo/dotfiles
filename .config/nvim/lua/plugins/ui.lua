return {
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          disabled_filetypes = { statusline = { "dashboard", "NvimTree" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
          lualine_x = {
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = function()
                return LazyVim.ui.fg("Debug")
              end,
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function()
                return LazyVim.ui.fg("Special")
              end,
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return "  " .. os.date("%I:%M %p")
            end,
          },
        },
        extensions = { "lazy" },
      }

      -- do not add trouble symbols if aerial is enabled
      -- And allow it to be overriden for some buffer types (see autocmds)
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "BufEnter",
    config = function()
      vim.diagnostic.config({ virtual_text = false })
      require("tiny-inline-diagnostic").setup()
    end,
  },

  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })

      local focused = true

      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })

      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })

      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.presets = vim.tbl_deep_extend("force", opts.presets, {
        lsp_doc_border = true,
        inc_rename = true,
      })
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      notifier = {
        enabled = true,
        timeout = 5000,
      },
      statuscolumn = {
        enabled = false,
      },
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    keys = {
      {
        "<Leader>g",
        ":LazyGit<Return>",
        silent = true,
        noremap = true,
        desc = "Lazy git",
      },
    },
  },

  -- {
  --   "kristijanhusak/vim-dadbod-ui",
  --   dependencies = {
  --     { "tpope/vim-dadbod", lazy = true },
  --     { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  --   },
  --   cmd = {
  --     "DBUI",
  --     "DBUIToggle",
  --     "DBUIAddConnection",
  --     "DBUIFindBuffer",
  --   },
  --   init = function()
  --     vim.g.db_ui_use_nerd_fonts = 1
  --   end,
  --   keys = {
  --     {
  --       "<leader>dd",
  --       "<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
  --     },
  --   },
  -- },

  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")

          local function opts(desc)
            return {
              desc = "nvim-tree: " .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            }
          end

          api.config.mappings.default_on_attach(bufnr)

          -- toggle smartly
          local nvimTreeFocusOrToggle = function()
            local currentBuf = vim.api.nvim_get_current_buf()
            local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
            if currentBufFt == "NvimTree" then
              api.tree.toggle()
            else
              api.tree.focus()
            end
          end
          vim.keymap.set("n", "<Leader>e", nvimTreeFocusOrToggle, { desc = "Toggle tree" })

          -- toggle the file explorer when opening a new tab
          vim.keymap.del("n", "<Tab>", { buffer = bufnr })
          vim.keymap.set("n", "ts", function()
            api.node.open.tab()
            api.tree.toggle()
          end, opts("Open: New Tab"))
          vim.keymap.set("n", "ws", api.node.open.vertical, opts("Open: Vertical Split"))
          vim.keymap.set("n", "cp", api.fs.copy.absolute_path, { desc = "Copy absolute path" })
        end,
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
          relativenumber = true,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })

      if vim.fn.argc(-1) == 0 then
        vim.cmd("NvimTreeFocus")
      end
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 10,
      open_mapping = [[<Leader>t]],
      hide_numbers = true,
      close_on_exit = true,
      direction = "horizontal",
      insert_mappings = false,
      persist_size = true,
      persist_mode = true,
      on_open = function(terminal)
        local nvimtree = require("nvim-tree.api")
        local nvimtree_view = require("nvim-tree.view")

        if nvimtree_view.is_visible() and terminal.direction == "horizontal" then
          local nvimtree_width = vim.fn.winwidth(nvimtree_view.get_winnr())

          nvimtree.tree.toggle()
          nvimtree_view.View.width = nvimtree_width
          nvimtree.tree.toggle(false, true)
        end
      end,
    },
  },
}
