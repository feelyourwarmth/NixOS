return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          -- 1. Hides the "Explorer" text at the top
          title = false,

          layout = {
            -- 2. Hides the "Search" box completely unless you press `/`
            auto_hide = { "input" },
          },
        },
      },
    },
  },
}
