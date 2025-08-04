return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>t", "<cmd>ToggleTerm all size=80 direction=float<cr>", mode = "n", desc = "Open terminal" },
      { "t", "<cmd>ToggleTerm all size=80 direction=float<cr>", mode = "n", desc = "Open terminal" },
      { "<esc>", "<cmd>ToggleTerm all<cr>", mode = "t", desc = "Close terminal" },
    },
    config = function()
      require("toggleterm").setup({ shade_terminals = false })
    end,
  },
}
