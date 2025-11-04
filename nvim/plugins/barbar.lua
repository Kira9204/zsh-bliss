-- https://github.com/romgrk/barbar.nvim/blob/master/README.md
return {
  { "lewis6991/gitsigns.nvim", version = "*", enabled = true },
  { "nvim-tree/nvim-web-devicons", version = "*", enabled = true },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    keys = {
      { "<leader>b", "<cmd>BufferPick<cr>", mode = "n", desc = "Choose an open buffer/tab by character" },
      { "<leader>n", "<cmd>tabnew<cr>", mode = "n", desc = "Open a new buffer/tab" },
      { "<leader>c", "<cmd>BufferClose<cr>", mode = "n", desc = "Close the open buffer/tab" },
      { "<C-b>", "<cmd>BufferPick<cr>", mode = "n", desc = "Choose an open buffer/tab by character" },
      { "<C-n>", "<cmd>tabnew<cr>", mode = "n", desc = "Open a new buffer/tab" },
      { "<C-c>", "<cmd>BufferClose<cr>", mode = "n", desc = "Close the open buffer/tab" },
    },
  },
}
