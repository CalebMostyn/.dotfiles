return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    input = {
      win = {
        position = "float",
        relative = "editor",
        row = math.floor(vim.o.lines / 2),
        col = math.floor((vim.o.columns - 60) / 2),
        width = 60,
        height = 1,
      },
    }
  }
}
