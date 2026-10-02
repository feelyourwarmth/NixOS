return {
  {
    "goolord/alpha-nvim",
    opts = {
      header = vim.split(vim.fn.system("fastfetch"), "\n"),
      buttons = {
        {
          action = "ene | startinsert",
          desc = " New File ",
          key = "n",
          icon = "󰈔 ",
        },
      },
    },
  },
}
