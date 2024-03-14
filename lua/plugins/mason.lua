return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- Ansible
      "ansible-language-server",
      "ansible-lint",

      -- Bash
      "bash-language-server",
      "shellcheck",
      "shfmt",
    },
  },
}
