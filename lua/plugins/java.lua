return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      jdtls = function(opts)
        opts.root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" })
        vim.list_extend(opts.cmd, {
          "-Xmx4g",
        })
        opts.settings = {
          java = {
            format = {
              enabled = false,
            },
          },
        }
        opts.handlers = {
          ["$/progress"] = function(_)
            -- disable progress updates.
          end,
        }
        return opts
      end,
    },
  },
}
