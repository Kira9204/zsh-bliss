return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      term_colors = true,
      transparent_background = false,
      integrations = {
        telescope = {
          enabled = true,
        },
      },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },
}
