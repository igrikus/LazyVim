return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    { "<leader>E", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
  },
  opts = {
    filesystem = {
      bind_to_cwd = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".terraform.lock.hcl",
        },
        never_show = {
          ".git",
          ".idea",
        },
        always_show = {
          "nocommit",
        },
        always_show_by_pattern = { -- uses glob style patterns
          "*.env",
          "*.env.*",
          "*.tfvars",
        },
      },
      -- Add the commands table here
      commands = {
        avante_add_files = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local relative_path = require("avante.utils").relative_path(filepath)

          local sidebar = require("avante").get()

          local open = sidebar:is_open()
          -- ensure avante sidebar is open
          if not open then
            require("avante.api").ask()
            sidebar = require("avante").get()
          end

          sidebar.file_selector:add_selected_file(relative_path)

          -- remove neo tree buffer
          if not open then
            sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
          end
        end,
      },
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          vim.opt.relativenumber = true
        end,
      },
    },
    window = {
      mappings = {
        ["h"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" and node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" then
            if not node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            elseif node:has_children() then
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        end,
        ["Y"] = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          -- Function to get git repository URL
          local function get_git_repo_url()
            local git_remote_output = vim.fn.systemlist("git config --get remote.origin.url")[1]
            return git_remote_output
          end

          local function is_git_repo()
            local git_remote_output = get_git_repo_url()
            return git_remote_output and git_remote_output ~= ""
          end

          -- Function to get current branch name
          local function get_git_branch()
            local git_branch_output = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
            return git_branch_output
          end

          -- Function to create file URL in git repository
          local function create_git_file_url(repo_url, branch, file_path)
            -- Convert repo URL to https if it's ssh
            if repo_url:match("^git@") then
              repo_url = repo_url:gsub(":", "/"):gsub("^git@", "https://")
            elseif repo_url:match("^ssh://") then
              repo_url = repo_url:gsub("^ssh://git@", "https://")
              repo_url = repo_url:gsub(":%d+/", "/") -- Remove the port number
            end
            repo_url = repo_url:gsub("%.git$", "") -- Remove .git suffix if exists
            return string.format("%s/blob/%s/%s", repo_url, branch, file_path)
          end

          -- Determine if we can get Git information
          local git_repo_url = nil
          local git_branch = nil
          local git_file_url = nil

          if is_git_repo() then
            git_repo_url = get_git_repo_url()
            git_branch = get_git_branch()
            git_file_url = create_git_file_url(git_repo_url, git_branch, modify(filepath, ":."))
          end

          local results = {
            filepath,
            modify(filepath, ":."),
            modify(filepath, ":~"),
            filename,
            modify(filepath, ":h"),
          }

          local choices = {
            "Absolute path: " .. results[1],
            "Path relative to CWD: " .. results[2],
            "Path relative to HOME: " .. results[3],
            "Filename: " .. results[4],
            "Directory: " .. results[5],
          }

          if git_file_url then
            table.insert(results, git_file_url)
            table.insert(choices, "Git repo URL: " .. git_file_url)
          end

          vim.ui.select(choices, { prompt = "Choose to copy to clipboard:" }, function(choice)
            if not choice then
              return
            end -- Handle case where selection is cancelled

            -- Find the index of the choice in the choices table
            for i, possible_choice in ipairs(choices) do
              if choice == possible_choice then
                local result = results[i]
                if result then
                  vim.fn.setreg("+", result)
                  vim.notify("Copied: " .. result)
                else
                  vim.notify("No result found", vim.log.levels.WARN)
                end
                return
              end
            end

            vim.notify("Selection not found", vim.log.levels.WARN)
          end)
        end,
        ["oa"] = "avante_add_files",
      },
    },
  },
}
