return {
  "3rd/image.nvim",
  config = function()
    require("image").setup({
      backend = "sixel",
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          only_render_image_at_cursor = false,
        },
      },
    })
  end,
}
