vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("lazy").setup("plugins")

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.hlsearch = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.undofile = true
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
