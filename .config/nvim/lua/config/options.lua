-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- options.lua

local opt = vim.opt

opt.number = true -- show line numbers
opt.relativenumber = true -- relative numbers
opt.tabstop = 4 -- number of spaces per tab
opt.shiftwidth = 4 -- number of spaces to use for autoindent
opt.expandtab = true -- convert tabs to spaces
opt.autoindent = true
opt.smartindent = true
opt.clipboard = "unnamedplus" -- system clipboard
