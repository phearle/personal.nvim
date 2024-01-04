return {
    'mbbill/undotree',
    keys = function()
        require('which-key').register({
            ['<leader>u'] = { name = '[U]ndotree', _ = 'which_key_ignore' },
        })
        return {
            { '<leader>ut', '<cmd>UndotreeToggle<cr>', desc = 'Undotree [T]oggle' },
        }
    end
}
