vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.autoformat = false
vim.g.have_nerd_font = false

vim.opt.number = false
vim.opt.relativenumber = false

vim.opt.mouse = ""
vim.opt.showmode = false
vim.opt.clipboard = ""
vim.opt.breakindent = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "no"
vim.opt.cursorline = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.termguicolors = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.hlsearch = true
vim.opt.scrolloff = 20
-- vim.opt.colorcolumn = "80"
