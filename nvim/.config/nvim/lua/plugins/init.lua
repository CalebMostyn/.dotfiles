-- install lazy.nvim 
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = "plugins.render-markdown" },
  { import = "plugins.neo-tree" },
  { import = "plugins.lsp-file-operations" },
  { import = "plugins.vim-slueth" },
  { import = "plugins.comment" },
  { import = "plugins.gitsigns" },
  { import = "plugins.which-key" },
  { import = "plugins.telescope" },
  -- { import = "plugins.lsp" },
  { import = "plugins.theme" },
  { import = "plugins.mini" },
  { import = "plugins.treesitter" },
  { import = "plugins.vim-be-good" },
  { import = "plugins.harpoon" },
  { import = "plugins.vim-surround" },
  { import = "plugins.indent-line" },
  { import = "plugins.autopairs" },
  { import = "plugins.undotree" },
},
{
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
