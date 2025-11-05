return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    local ws = require("which-key")
    ws.setup()
    -- Document existing key chains
    ws.add({
      { "<leader>b", group = "Choose an open buffer/tab by character" },
      { "<leader>e", group = "Open Neo-tree. Use ctrl+h and ctrl+l" },
      { "<leader>f", group = "Find files/actions" },
      { "<leader>fa", group = "Find action" },
      { "<leader>ff", group = "Find file" },
      { "<leader>fg", group = "Find filecontaining using grep" },
      { "<leader>t", group = "Open terminal" },
      { "<leader>u", group = "Toggle undo tree" },
    })
  end,
}
