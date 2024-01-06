return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {},
    },
    {
        'kdheepak/lazygit.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        keys = function()
            require('which-key').register({
                ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
            })
            return {
                { '<leader>gg', '<cmd>:LazyGit<cr>', desc = 'LazyGit UI' },
            }
        end,
        config = function()
            require('telescope').load_extension('lazygit')
        end,
    }
}
