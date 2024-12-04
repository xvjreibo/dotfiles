local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

keymap.set({ "x", "n", "s" }, "<C-s>", "<cmd>up<cr><esc>", opts)
keymap.set("n", "<Leader>q", ":wall|qa!<Return><esc>", { noremap = true, silent = true, desc = "Update all and quit" })

-- Tabs > Windows
-- Split tab
keymap.set("n", "tc", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ws", ":vsplit<Return>", opts)
keymap.set("n", "wc", ":close<Return>", opts)

-- Move Between windows
keymap.set({ "x", "n", "s" }, "[", "<C-w>h", opts)
keymap.set({ "x", "n", "s" }, "]", "<C-w>l", opts)
keymap.set({ "x", "n", "s" }, "\\", "<C-w>w", opts)

local keys = require("lazyvim.plugins.lsp.keymaps").get()
keys[#keys + 1] = { "]]", false }
keys[#keys + 1] = { "[[", false }

vim.keymap.set("n", "<C-_>", ":normal gcc<cr><down>", opts)
vim.keymap.set("v", "<C-_>", "<esc>:normal gvgc<cr>", opts)

local Terminal = require("toggleterm.terminal").Terminal

function _G.open_next_terminal()
  local direction = "horizontal"
  Terminal:new({
    close_on_exit = true,
    direction = direction,
  }):toggle()
end

function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "[", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "]", [[<C-\><C-n><C-W>l]], opts)
  vim.api.nvim_buf_set_keymap(0, "n", "ts", "<cmd>lua open_next_terminal()<CR>", opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity, float = false })
  end
end

keymap.set("n", "<C-j>", diagnostic_goto(true), opts)
