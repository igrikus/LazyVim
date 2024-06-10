return {
  "LintaoAmons/scratch.nvim",
  event = "VeryLazy",
  keys = {
    { "<M-C-n>", "<cmd>Scratch<cr>", desc = "Create scratch file" },
    { "<M-C-o>", "<cmd>ScratchOpen<cr>", desc = "Open scratch file" },
  },
  opts = {
    filetypes = {
      "xml",
      "go",
      "lua",
      "js",
      "py",
      "sh",
      "ps1",
      "json",
      "yaml",
      "txt",
    },
  },
}
