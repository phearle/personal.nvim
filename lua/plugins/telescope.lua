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
            'nvim-telescope/telescope-frecency.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        keys = function()
            local git_root = nil
            local builtin = require('telescope.builtin')
            local get_git_root = function()
                if not git_root then
                    git_root = find_git_root()
                end
                return git_root
            end

            local file_finder = function()
                local file_ignore_patterns = {
                    '!node_modules',
                    '!.git',
                    '!*templ.go',
                    '!*.sqlite3',
                }
                local find_command = { 'rg', '--files', '--hidden' }
                for _, p in ipairs(file_ignore_patterns) do
                    table.insert(find_command, '-g')
                    table.insert(find_command, p)
                end
                return function()
                    return builtin.find_files({
                        find_command = find_command,
                        cwd = get_git_root(),
                    })
                end
            end
            local live_grep_finder = function()
                return function()
                    return builtin.live_grep({
                        cwd = get_git_root()
                    })
                end
            end
            require('which-key').add({
                { '<leader>s',  group = 'Telescope' },
                { '<leader>s_', hidden = true },
            })
            return {
                { "<leader><space>", builtin.buffers,               desc = "Search Buffers" },
                { "<leader>sc",      builtin.commands,              desc = "Search Commands" },
                { "<leader>sd",      builtin.diagnostics,           desc = "Search Diagnostics" },
                { "<leader>sf",      file_finder(),                 desc = "Search Files" },
                { "<leader>sg",      live_grep_finder(),            desc = "Live Grep" },
                { "<leader>ss",      builtin.grep_string,           desc = "Grep Cursor String" },
                { "<leader>sh",      builtin.help_tags,             desc = "Search Help tags" },
                { "<leader>st",      builtin.builtin,               desc = "Search Select Telescope" },
                { "<leader>sq",      '<cmd>Telescope frecency<cr>', desc = "Search Frecency" },
                { "<leader>sr",      builtin.resume,                desc = "Resume" },
            }
        end,
        config = function()
            require('telescope').setup({
                defaults = {
                    layout_config = {
                        vertical = { width = 0.9 },
                    },
                    mappings = {
                        i = { ["<c-t>"] = require('trouble.sources.telescope').open },
                        n = { ["<c-t>"] = require('trouble.sources.telescope').open },
                    },
                },
                pickers = {
                    find_files = {
                        layout_strategy = 'vertical',
                    },
                    buffers = {
                        layout_strategy = 'vertical',
                    },
                    live_grep = {
                        layout_strategy = 'vertical',
                    },
                    grep_string = {
                        layout_strategy = 'vertical',
                    },
                    diagnostics = {
                        layout_strategy = 'vertical',
                    },
                    help_tags = {
                        layout_strategy = 'vertical',
                    },
                    builtin = {
                        layout_strategy = 'vertical',
                    },
                    lsp_references = {
                        layout_strategy = 'vertical',
                    },
                    commands = {
                        theme = 'ivy',
                        layout_strategy = 'vertical',
                    },
                },
                extensions = {
                    frecency = {
                        theme = 'ivy',
                        layout_strategy = 'vertical',
                    },
                },
            })
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('frecency')
        end,
    },
}
