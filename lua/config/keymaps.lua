-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<C-_>") -- Disable built-in terminal

vim.keymap.set({ "n", "v" }, "x", '"_x') -- Don't yank when cutting

vim.keymap.set({ "n", "v" }, "d", '"_d') -- Don't yank when deleting
vim.keymap.set({ "n", "v" }, "D", '"_D')

vim.keymap.set({ "n", "v" }, "c", '"_c') -- Don't yank when changing
vim.keymap.set({ "n", "v" }, "C", '"_C')

local function compare_to_clipboard()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd(string.format(
    [[
    execute "normal! \"xy"
    vsplit
    enew
    normal! P
    setlocal buftype=nowrite
    set filetype=%s
    diffthis
    execute "normal! \<C-w>\<C-w>"
    enew
    set filetype=%s
    normal! "xP
    diffthis
  ]],
    ftype,
    ftype
  ))
end

vim.keymap.set("x", "<Space>cc", compare_to_clipboard, { desc = "Compare selection with clipboard" })
