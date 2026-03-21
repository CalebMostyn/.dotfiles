return {
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        transparent = true,
        styles = {
          sidebars = 'transparent',
          floats = 'transparent',
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      vim.cmd.colorscheme 'tokyonight-storm'
    end,
  },
  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },
}
