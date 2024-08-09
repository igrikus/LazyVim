return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = {},
      java = { "checkstyle" },
    },
    linters = {
      checkstyle = {
        args = { "-c", vim.fn.expand("$HOME/Documents/checkstyle.xml") },
      },
    },
  },
}
