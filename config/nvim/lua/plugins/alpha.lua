return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      local custom_ascii = {
        [[                                   ]],
        [[  ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·.  ]],
        [[ •█▌▐█▀▄.▀·▪     ▪█·█▌██ ·██ ▐███▪ ]],
        [[ ▐█▐▐▌▐▀▀▪▄ ▄█▀▄ ▐█▐█•▐█·▐█ ▌▐▌▐█· ]],
        [[ ██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌ ]],
        [[ ▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀ ]],
        [[                                   ]],
      }

      local handle = io.popen("fastfetch -l none --pipe")
      local result = handle:read("*a")
      handle:close()

      result = string.gsub(result, "\27%[[0-9;]*[mKABCDEFGHfJ]", "")
      result = result:match("^%s*(.-)%s*$")

      local fastfetch_lines = vim.split(result, "\n")

      vim.api.nvim_set_hl(0, "AlphaWhiteText", { fg = "#FFFFFF" })

      dashboard.section.header.val = custom_ascii
      dashboard.section.header.opts.hl = "AlphaWhiteText"

      dashboard.section.buttons.val = {
        dashboard.button("n", "󰈔  New File", "<cmd>ene | startinsert<CR>"),
        dashboard.button("p", "󰉋  Load Projects", "<cmd>e ~/projects<CR>"),
        dashboard.button("q", "󰈆  Quit", "<cmd>qa<CR>"),
      }
      dashboard.section.buttons.opts.spacing = 0

      local total_height = #custom_ascii + 1 + #fastfetch_lines + 1 + 3

      dashboard.config.layout = {
        {
          type = "padding",
          val = function()
            return math.max(0, math.floor((vim.o.lines - total_height) / 2))
          end,
        },
        dashboard.section.header,
        { type = "padding", val = 1 },
        fastfetch_section,
        { type = "padding", val = 1 },
        dashboard.section.buttons,
      }

      return dashboard
    end,
    config = function(_, dashboard)
      require("alpha").setup(dashboard.opts)
    end,
  },
}
