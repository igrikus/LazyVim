return {
  "linux-cultist/venv-selector.nvim",
  lazy = false,
  opts = {
    settings = {
      options = {
        debug = true,
        require_lsp_activation = false,
        cached_venv_automatic_activation = false,
      },
    },
  },

  -- By default plugin activates only when python file is opened. I need to activate it globally
  ft = function(_, _)
    return {}
  end,
  keys = { { "<leader>cv", false } },
}
