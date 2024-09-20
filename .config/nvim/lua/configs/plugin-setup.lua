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

require("lazy").setup({
    { "EdenEast/nightfox.nvim" }, 
	{"ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate",},
	{'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }},
	{"nvim-tree/nvim-tree.lua", version = "*", lazy = false, dependencies = { "nvim-tree/nvim-web-devicons",},
		config = function()
			require("nvim-tree").setup {}
		end,},
	{'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = { 'nvim-lua/plenary.nvim' }},
  	{'romgrk/barbar.nvim', dependencies = {'lewis6991/gitsigns.nvim', 'nvim-tree/nvim-web-devicons'}},
	{'nvimdev/dashboard-nvim', event = 'VimEnter', dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
})

