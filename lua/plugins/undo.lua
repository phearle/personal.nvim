return {
    'mbbill/undotree',
    keys = function()
        require('which-key').register({
            ['<leader>u'] = { name = 'Undotree', _ = 'which_key_ignore' },
        })
        return {
            { '<leader>ut', '<cmd>UndotreeToggle<cr>', desc = 'Undotree Toggle' },
        }
    end
}
