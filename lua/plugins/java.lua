return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      jdtls = function(opts)
        opts.root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" })
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
