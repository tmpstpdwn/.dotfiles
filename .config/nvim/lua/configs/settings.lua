-- Settings

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.autoindent = true    -- Enable auto-indenting
vim.opt.smartindent = true   -- Enable smart-indenting
vim.opt.tabstop = 4          -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4        -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.ignorecase = true     -- Ignore case when searching
vim.opt.smartcase = true      -- Override 'ignorecase' if the search pattern contains uppercase characters
vim.opt.splitright = true     -- Vertical splits will automatically be to the right of the current window
vim.opt.splitbelow = true     -- Horizontal splits will automatically be below the current window
vim.opt.wrap = false          -- Disable line wrapping
vim.opt.syntax = 'enable'     -- Enable syntax highlighting
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
--
-- colorscheme

vim.cmd 'colorscheme gruvbox' 

vim.cmd [[
  hi Normal guibg=NONE ctermbg=NONE
  hi NonText guibg=NONE ctermbg=NONE
]]

-- End
