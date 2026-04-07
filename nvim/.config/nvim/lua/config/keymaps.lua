-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Toggle transparency on gnome-terminal
vim.keymap.set('n', '<leader>tp', ':! gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ background-transparency-percent 5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>to', ':! gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ background-transparency-percent 0<CR>', { noremap = true, silent = true })

-- Open netrw
-- vim.keymap.set("n", "<leader>n", vim.cmd.Ex)

-- move current line in normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")

-- move highlighted lines in visual mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- keep cursor in same place on line joins
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in middle vertically on page movements
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- quickfix movement
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- starts a %s with current word
vim.keymap.set("n", "<leader>%", function()
  local word = vim.fn.expand("<cword>")
  if word == "" then return end
  -- escape backslashes and quotes for command-line feeding
  local escaped = word:gsub([[\]], [[\\]]):gsub([["]], [[\"]])
  -- use \V for very nomagic pattern, so regex chars are literal
  local cmd = ':%s/\\V' .. escaped .. '//gc'
  vim.api.nvim_feedkeys(cmd .. vim.api.nvim_replace_termcodes('<Left><Left><Left>', true, false, true), 'n', false)
end, { noremap = true, silent = false })
-- starts a %s with current highlight
vim.keymap.set("v", "<leader>%", function()
  -- yank visual selection into register h
  vim.cmd('normal! "hy')
  local text = vim.fn.getreg('h')
  if text == "" then return end
  -- escape backslashes and quotes for command-line
  local escaped = text:gsub([[\]], [[\\]]):gsub([["]], [[\"]])
  -- feed the command-line for interactive :%s with cursor ready
  local cmd = ':%s/' .. escaped .. '//gc'
  -- enter command-line mode with the command prefilled
  vim.api.nvim_feedkeys(cmd .. vim.api.nvim_replace_termcodes('<Left><Left><Left>', true, false, true), 'n', false)
end, { noremap = true, silent = false })

-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set('n', '<leader>dt', function()
  local vt = vim.diagnostic.config().virtual_text
  local s = vim.diagnostic.config().signs
  vim.diagnostic.config({
    virtual_text = not vt,
    signs = not s
  })
end, { noremap = true, silent = true })
