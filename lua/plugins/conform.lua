return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      prettier = {
        condition = function()
          return vim.bo.filetype ~= "yaml"
        end,
      },
    },
  },
}
