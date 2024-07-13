return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {},
    },
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'nvim-telescope/telescope.nvim',
        },
        keys = function()
            require('which-key').add({
                { "<leader>g",  group = "Git" },
                { "<leader>g_", hidden = true },
            })
            return {
                { '<leader>gg', '<cmd>Neogit kind=split_above cwd=%:p:h<cr>', desc = 'Open Neogit' },
            }
        end,
        config = true
    }
    -- {
    --     'kdheepak/lazygit.nvim',
    --     dependencies = {
    --         'nvim-lua/plenary.nvim'
    --     },
    --     keys = function()
    --         require('which-key').register({
    --             ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
    --         })
    --         return {
    --             { '<leader>gg', '<cmd>:LazyGit<cr>', desc = 'LazyGit UI' },
    --         }
    --     end,
    --     config = function()
    --         require('telescope').load_extension('lazygit')
    --     end,
    -- }
}
