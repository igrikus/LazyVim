return {
  "linux-cultist/venv-selector.nvim",
  branch = "main",
  commit = "2ad34f36d498ff5193ea10f79c87688bd5284172",
  cmd = "VenvSelect",
  opts = function(_, opts)
    if LazyVim.has("nvim-dap-python") then
      opts.dap_enabled = true
    end
    return vim.tbl_deep_extend("force", opts, {
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
    })
  end,
  keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
}
