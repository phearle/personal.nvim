return {
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },
    {
        'kdheepak/lazygit.nvim',
        keys = function()
            require('which-key').register({
                ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
            })
            return {
                { '<leader>gg', '<cmd>:LazyGit<cr>', desc = 'LazyGit UI' },
            }
        end,
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
    }
}
