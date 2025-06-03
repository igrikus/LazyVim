return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {

      -- Bash
      "bash-language-server",
      "shellcheck",
      "shfmt",

      -- PowerShell
      "powershell-editor-services",

      -- HashiCorp
      "hclfmt",

      -- Java
      "checkstyle",

      -- Grammar
      "harper-ls",
    })
  end,
}
