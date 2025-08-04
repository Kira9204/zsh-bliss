return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup()
    -- Document existing key chains
    require("which-key").register({
      ["<leader>e"] = { name = "Open Neo-tree. Use ctrl+h and ctrl+l", _ = "which_key_ignore" },
      ["<leader>b"] = { name = "Choose an open buffer/tab by character", _ = "which_key_ignore" },
      ["<leader>t"] = { name = "Open terminal", _ = "which_key_ignore" },
      ["<leader>u"] = { name = "Toggle undo tree", _ = "which_key_ignore" },
      ["<leader>f"] = { name = "Find files/actions", _ = "which_key_ignore" },
      ["<leader>fa"] = { name = "Find action", _ = "which_key_ignore" },
      ["<leader>ff"] = { name = "Find file", _ = "which_key_ignore" },
      ["<leader>fg"] = { name = "Find filecontaining using grep", _ = "which_key_ignore" },
    })
  end,
}
