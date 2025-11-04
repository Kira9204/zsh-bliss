-- Disable search hilighting after pressing ESC
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "w", "<cmd>w<cr>", { noremap = true })
vim.keymap.set("n", "q", "<cmd>q!<cr> | <cmd>q!<cr> | <cmd>q!<cr> | <cmd>q!<cr>", { noremap = true })
vim.keymap.set("n", "r", "<cmd>redo<cr>", { noremap = true })

-- Create a new tab with :tabnew
-- vim.keymap.set('n', '<C-b>', '<cmd>BufferPick<cr>', { noremap = true })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
