vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "> ", trail = ".", nbsp = "+" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.whichwrap = "b,s"

vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map({ "n", "v" }, "<M-h>", "5h")
map({ "n", "v" }, "<M-j>", "5j")
map({ "n", "v" }, "<M-k>", "5k")
map({ "n", "v" }, "<M-l>", "5l")

-- Keep mouse enabled for scrolling/resizing, but avoid accidental cursor jumps.
map({ "", "i", "c" }, "<LeftMouse>", "<Nop>")
map({ "", "i", "c" }, "<LeftRelease>", "<Nop>")
map({ "", "i", "c" }, "<2-LeftMouse>", "<Nop>")
map({ "", "i", "c" }, "<RightMouse>", "<Nop>")
map({ "", "i", "c" }, "<MiddleMouse>", "<Nop>")
