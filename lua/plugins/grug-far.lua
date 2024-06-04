return {
  "MagicDuck/grug-far.nvim",
  opts = {},
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").grug_far()
      end,
      desc = "Replace in Files (grug-far)",
    },
  },
}
