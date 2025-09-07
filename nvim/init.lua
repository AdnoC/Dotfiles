vim.g.mapleader = " " -- Set leader key before Lazy
vim.keymap.set("i", "kj", "<ESC>")
vim.keymap.set("n", "tt", ":b#<CR>")
vim.keymap.set("n", "]b", ":bnext<CR>")
vim.keymap.set("n", "[b]", ":bprev<CR>")
vim.opt.nu = true
vim.opt.mouse = ''
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

require("config.lazy")
