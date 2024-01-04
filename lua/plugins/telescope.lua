-- Taken from kickstart.nvim
local function find_git_root()
    -- Use the current buffer's path as the starting point for the git search
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    -- If the buffer is not associated with a file, return nil
    if current_file == '' then
        current_dir = cwd
    else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
    end

    -- Find the Git root directory from the current file's path
    local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
    if vim.v.shell_error ~= 0 then
        print 'Not a git repository. Searching on current working directory'
        return cwd
    end
    return git_root
end

return {
    {
        'nvim-telescope/telescope.nvim',
        name = 'telescope',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            }
        },
        keys = function()
            local builtin = require('telescope.builtin')
            local git_root = nil
            local get_git_root = function()
                if not git_root then
                    git_root = find_git_root()
                end
                return git_root
            end
            local find_files = function()
                return builtin.find_files({
                    cwd = get_git_root()
                })
            end
            local live_grep = function()
                return builtin.live_grep({
                    cwd = get_git_root()
                })
            end
            require('which-key').register({
                ['<leader>s'] = { name = 'Tele[s]cope', _ = 'which_key_ignore' },
            })
            return {
                { "<leader><space>", builtin.buffers,     desc = "Search Buffers" },
                { "<leader>sc",      builtin.colorscheme, desc = "Search [C]olorschemes" },
                { "<leader>sd",      builtin.diagnostics, desc = "Search [D]iagnostics" },
                { "<leader>sf",      find_files,          desc = "Search [F]iles" },
                { "<leader>sg",      live_grep,           desc = "Live [G]rep" },
                { "<leader>sh",      builtin.help_tags,   desc = "Search [H]elp tags" },
                { "<leader>ss",      builtin.builtin,     desc = "Search [S]elect Telescope" },
            }
        end,
        config = function()
            pcall(require('telescope').load_extension, 'fzf')
        end,
    }
}
