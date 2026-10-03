return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  event = "VeryLazy",
  opts = {
    display = {
      theme = "minecraft",
    },
    idle = {
      enabled = false,
    },
  },
}
