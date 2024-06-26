return {
  "nvimdev/dashboard-nvim",
  opts = {
    config = {
      header = vim.fn.readfile(vim.fn.stdpath("config") .. "/dashboard-logo.txt"),
    },
  },
}
