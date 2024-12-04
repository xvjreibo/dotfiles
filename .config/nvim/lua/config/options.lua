vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.backup = false -- create a backup file

vim.opt.title = true -- set the terminal title
vim.opt.number = true -- display the line number
-- vim.opt.wrap = true
vim.opt.breakindent = true -- indents the wrapped text if necessary
vim.opt.splitbelow = true -- split the window down below
vim.opt.splitright = true

vim.opt.smartindent = true -- adjust the indentation rule to specific languages
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.tabstop = 2 -- spacify the number of spaces a tab character will occupy
vim.opt.shiftwidth = 2 -- specify the number of >> will occupy
vim.opt.inccommand = "split" -- preview the replacement results
vim.opt.backspace = { "start", "eol", "indent" } -- specify what could be r[moved using backspace
-- vim.opt.formatoptions:append({ "r" }) -- insert comment leader on the next line
vim.opt.scrolloff = 10 -- control the number of lines that are kept visible above and below the cursor
vim.opt.mouse = "a"
vim.opt.list = false

vim.opt.hlsearch = true -- highlight search results
vim.opt.ignorecase = true
vim.opt.path:append({ "**" }) -- searches recursively in subdirectories
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.guicursor = {
  "n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}

if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.smoothscroll = true
end
