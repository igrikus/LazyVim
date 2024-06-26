return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      bind_to_cwd = true,
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

          -- Get git information
          local git_repo_url = get_git_repo_url()
          local git_branch = get_git_branch()
          local git_file_url = create_git_file_url(git_repo_url, git_branch, modify(filepath, ":."))

          local results = {
            filepath,
            modify(filepath, ":."),
            modify(filepath, ":~"),
            filename,
            modify(filename, ":r"),
            modify(filename, ":e"),
            git_file_url,
          }

          vim.ui.select({
            "1. Absolute path: " .. results[1],
            "2. Path relative to CWD: " .. results[2],
            "3. Path relative to HOME: " .. results[3],
            "4. Filename: " .. results[4],
            "5. Filename without extension: " .. results[5],
            "6. Extension of the filename: " .. results[6],
            "7. Git repo file URL: " .. results[7],
          }, { prompt = "Choose to copy to clipboard:" }, function(choice)
            local i = tonumber(choice:sub(1, 1))
            local result = results[i]
            vim.fn.setreg("+", result)
            vim.notify("Copied: " .. result)
          end)
        end,
      },
    },
  },
}
