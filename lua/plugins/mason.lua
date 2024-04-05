return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- Bash
      "bash-language-server",
      "shellcheck",
      "shfmt",

      -- PowerShell
      "powershell-editor-services",

      -- HashiCorp
      "hclfmt",

      -- Markdown
      "markdownlint",
    },
  },
}
