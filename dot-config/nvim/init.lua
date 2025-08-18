-- [[ A minimal configuration modified from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua ]]
-- [[ Essential keymaps ]]
-- Set <space> as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make the curor in insert mode a block
-- vim.opt.guicursor = "n-v-c:block,i:block"
-- Disable the default behaviour of <s> key in normal mode
vim.keymap.set({ 'n', 'v' }, 's', '<Nop>')

-- [[ Clipboard and Register Settings ]]
-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'
-- In visual mode, put text without overwriting the register
vim.api.nvim_set_keymap('x', 'p', 'P', { noremap = true, silent = true })

-- https://stackoverflow.com/q/916875/17662217
vim.keymap.set({ 'n' }, '<Leader>p', ':let @+=expand("%")<CR>')

-- [[ Default Tab and Indentation Settings ]]
-- Language specific settings are in ./after/ftplugin/
vim.o.tabstop = 2 -- size of a hard tabstop (ts).
vim.o.shiftwidth = 2 -- size of an indentation (sw).
vim.o.expandtab = true -- always uses spaces instead of tab characters (et).
vim.o.softtabstop = 2 -- number of spaces a <Tab> counts for. When 0, feature is off (sts).

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
