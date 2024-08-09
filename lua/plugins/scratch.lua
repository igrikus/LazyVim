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
      "java",
      "py",
      "sh",
      "ps1",
      "json",
      "yaml",
      "txt",
    },
    filetype_details = {
      java = {
        content = {
          "class Scratch {",
          "    public static void main(String []args) {",
          "        ",
          "    }",
          "}",
        },
        cursor = {
          location = { 3, 6 },
          insert_mode = false,
        },
      },
    },
  },
}
