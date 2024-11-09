-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Auto select virtualenv on Nvim open",
  pattern = "*",
  callback = function()
    local venv_paths = { "venv", ".venv", "env", ".env" }
    for _, path in ipairs(venv_paths) do
      local venv = vim.fn.finddir(path, vim.fn.getcwd())
      if venv ~= "" then
        require("venv-selector").retrieve_from_cache()
        break
      end
    end
  end,
  once = true,
})
