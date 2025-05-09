-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<C-_>") -- Disable built-in terminal
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]])

vim.keymap.set({ "n", "v" }, "x", '"_x') -- Don't yank when cutting

vim.keymap.set({ "n", "v" }, "d", '"_d') -- Don't yank when deleting
vim.keymap.set({ "n", "v" }, "D", '"_D')

vim.keymap.set({ "n", "v" }, "c", '"_c') -- Don't yank when changing
vim.keymap.set({ "n", "v" }, "C", '"_C')

vim.keymap.set("n", "Q", "q", { noremap = true }) -- Change record key
vim.keymap.set("n", "q", "<Nop>", { noremap = true })

local function compare_to_clipboard()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd("vsplit")
  vim.cmd("enew")
  vim.cmd("normal! P")
  vim.cmd("setlocal buftype=nowrite")
  vim.cmd("set filetype=" .. ftype)
  vim.cmd("diffthis")
  vim.cmd([[execute "normal! \<C-w>h"]])
  vim.cmd("diffthis")
end

vim.keymap.set("v", "<Space>cs", compare_to_clipboard, { desc = "Compare selection with clipboard" })
