-- [[ A minimal configuration modified from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua ]]
-- [[ Essential keymaps ]]
-- Set <space> as the leader key.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Make the curor in insert mode a block
-- vim.opt.guicursor = "n-v-c:block,i:block"
-- Disable the default behaviour of <s> key in normal mode
vim.keymap.set({ "n", "v" }, "s", "<Nop>")

-- [[ Clipboard and Register Settings ]]
-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"
-- In visual mode, put text without overwriting the register
vim.api.nvim_set_keymap("x", "p", "P", { noremap = true, silent = true })

-- https://stackoverflow.com/q/916875/17662217
vim.keymap.set({ "n" }, "<Leader>p", ':let @+=expand("%")<CR>')

-- NOTE: Disable semantic highlights after coloscheme is set, due to:
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/5455
-- Also see `:h lsp-semantic-highlight`
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
end

vim.o.pumheight = 20 -- limit popup height
vim.o.number = true -- display line number
vim.o.relativenumber = true

-- Rest of the lines are shown on the next line if too long to fit on the screen
vim.o.breakindent = true

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
-- [[ Setup plugins ]]
require("lazy").setup("plugins")
