-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("t", "<C-l>") -- Clear terminal with Ctrl+l

vim.keymap.set({ "n", "v" }, "x", '"_x') -- Don't yank when cutting
vim.keymap.set({ "n", "v" }, "d", '"_d') -- Don't yank when deleting
vim.keymap.set({ "n", "v" }, "c", '"_c') -- Don't yank when changing
