return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 4      -- open on right, diff on bottom
    vim.g.undotree_SetFocusWhenToggle = 1 -- focus tree on toggle
  end,
}
