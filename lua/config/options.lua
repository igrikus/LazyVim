-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.spelllang = { "en", "ru_ru" }
vim.g.root_lsp_ignore = { "vtsls" }

-- Sync with system clipboard. LazyVim disables this over SSH (clipboard = "")
-- so we re-enable it and route copies through OSC 52, which pushes the text
-- down the SSH connection to the *local* terminal's clipboard.
vim.opt.clipboard = "unnamedplus"

if vim.env.SSH_TTY then
  local osc52 = require("vim.ui.clipboard.osc52")
  -- Paste-back over OSC 52 only works in a few terminals, so fall back to the
  -- register's stored value to avoid hangs while still copying out via OSC 52.
  local function paste()
    return function()
      return vim.split(vim.fn.getreg(""), "\n")
    end
  end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = paste(), ["*"] = paste() },
  }
end
