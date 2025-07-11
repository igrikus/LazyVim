return {
  "linux-cultist/venv-selector.nvim",
  cmd = "VenvSelect",
  opts = {
    settings = {
      options = {
        notify_user_on_venv_activation = false,
        require_lsp_activation = false,
      },
    },
  },
  enabled = true,
  keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
}
