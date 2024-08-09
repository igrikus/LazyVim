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
        return opts
      end,
    },
  },
}
