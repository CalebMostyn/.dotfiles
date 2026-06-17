-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Loads existing or starts an obsession session on enter
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local session = vim.fn.getcwd() .. "/Session.vim"

        if vim.fn.filereadable(session) == 1 then
            vim.cmd("source " .. vim.fn.fnameescape(session))
        else
            vim.cmd("Obsess")
        end
    end,
})
