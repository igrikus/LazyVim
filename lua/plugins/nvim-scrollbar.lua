local colors = require("tokyonight.colors").setup()

return {
  "petertriho/nvim-scrollbar",
  dependencies = { "kevinhwang91/nvim-hlslens" },
  opts = {
    handle = {
      color = colors.bg_highlight,
    },
    marks = {
      Search = { color = colors.orange },
      Error = { color = colors.error },
      Warn = { color = colors.warning },
      Info = { color = colors.info },
      Hint = { color = colors.hint },
      Misc = { color = colors.purple },
    },
    hide_if_all_visible = true,
    handlers = {
      gitsigns = true,
      search = true,
    },
  },
}
