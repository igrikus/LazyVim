return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<c-\>]],
    direction = "float",
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    local Terminal = require("toggleterm.terminal").Terminal

    local gemini = Terminal:new({
      cmd = "gemini",
      dir = vim.fn.getcwd(),
      direction = "float",
      hidden = true,
      count = 9,
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-\\>", "<cmd>close<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<C-\\>", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
    })

    function _G.toggle_gemini()
      gemini:toggle()
    end

    vim.keymap.set("n", "<leader>aa", "<cmd>lua _G.toggle_gemini()<CR>", { desc = "Toggle gemini terminal" })
  end,
}
