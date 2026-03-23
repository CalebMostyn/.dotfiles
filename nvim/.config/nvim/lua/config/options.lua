-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- using nerd font for icons/symbols
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Not actually doing anything?
vim.opt.showmode = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = ' ⇥', trail = '·', nbsp = '␣', space = '·', eol = '↴' }
-- should be setting whitespace to be slightly darker? can't tell if its working
vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#222222' }) -- dark gray for subtle look

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.opt.confirm = true

-- Use spaces instead of tabs
vim.opt.expandtab = true       -- Converts tabs to spaces
vim.opt.tabstop = 4            -- Number of spaces in a tab
vim.opt.shiftwidth = 4         -- Number of spaces for autoindent
vim.opt.softtabstop = 4        -- Number of spaces for each press of the Tab key
